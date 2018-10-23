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
    var globalPeripheralName = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        self.globalPeripheralName = ""
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(scanForDevices), for: .valueChanged)
        self.refreshControl = refresh
//        createGradientLayer()
    }
    
//    func createGradientLayer() {
//        gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [ UIColor(red: 35.0 / 255.0, green: 29.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 95.0 / 255.0, green: 88.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
    
    override func prepare(for segue: UIStoryboardSegue!, sender: Any?) {
        var nextViewConteoller = segue.destination as? ViewController
        nextViewConteoller?.connectedTo = self.globalPeripheralName
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // HARD CODEED
        //return self.bleShield.peripherals.count
        return 1
    }
// ATTENTION 
    @objc func scanForDevices() {
        print("Scanning for devices...")
        // disconnect from any peripherals
        for peripheral in bleShield.peripherals {
            if(peripheral.state == .connected){
                bleShield.disconnectFromPeripheral(peripheral: peripheral)
            }
        }

        //start search for peripherals with a timeout of 3 seconds
        // this is an asynchronous call and will return before search is complete
        if(bleShield.startScanning(timeout: 3.0)){
            // after three seconds, try to connect to first peripheral
            Timer.scheduledTimer(withTimeInterval: 3.0,
                                 repeats: false,
                                 block: self.didFinishScanning)
        }

    }
    func didFinishScanning(timer:Timer){
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath)
        // ATTENTION
        //let peripheral = self.bleShield.peripherals[indexPath.row]
        //print("peripheral name: ", peripheral.name!)
        //cell.textLabel?.text = peripheral.name!
        cell.textLabel?.text = "Brandon's BLE Chip"
        //cell.detailTextLabel?.text = peripheral.identifier.uuidString
        cell.detailTextLabel?.text = "I am a uuidString!"
        print("CELL: ", cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ATTENTION
        //var peripheral = self.bleShield.peripherals[indexPath.row]
        //print("peripheral: ", peripheral)
        //self.bleShield.connectToPeripheral(peripheral: peripheral)
        //print("connected to peripheral")
        //self.globalPeripheralName = peripheral.name!
        //print("global: ", self.globalPeripheralName)
        self.globalPeripheralName = "Brandon's BLE Chip"
    }
}
