//
//  ChipTableViewController.swift
//  BluetoothLab
//
//  Created by Brandon McFarland on 10/19/18.
//  Copyright © 2018 MobileSensingLearning. All rights reserved.
//

import Foundation
import UIKit

class ChipTableViewController: UITableViewController {
    lazy var bleShield:BLE = (UIApplication.shared.delegate as! AppDelegate).bleShield
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(scanForDevices), for: .valueChanged)
        self.refreshControl = refresh
    }
    
    // Set number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Set number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bleShield.peripherals.count
    }

    // Scan for devices
    @objc func scanForDevices() {
        print("Scanning for devices...")
        for peripheral in bleShield.peripherals {
            if(peripheral.state == .connected){
                bleShield.disconnectFromPeripheral(peripheral: peripheral)
            }
        }

        //start search for peripherals with a timeout of 3 seconds. After three seconds, try to connect to first peripheral
        if(bleShield.startScanning(timeout: 3.0)){
            Timer.scheduledTimer(withTimeInterval: 3.0,
                                 repeats: false,
                                 block: self.didFinishScanning)
        }

    }
    
    // Finished scanning function
    func didFinishScanning(timer:Timer){
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    // Construct the table cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath)
        let peripheral = self.bleShield.peripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name!
        cell.detailTextLabel?.text = peripheral.identifier.uuidString
        return cell
    }
    
    // Connect to peripheral when a row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = self.bleShield.peripherals[indexPath.row]
        self.bleShield.connectToPeripheral(peripheral: peripheral)
    }
}
