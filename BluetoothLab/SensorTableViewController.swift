//
//  SensorTableViewController.swift
//  BluetoothLab
//
//  Created by Brandon McFarland on 10/19/18.
//  Copyright © 2018 MobileSensingLearning. All rights reserved.
//

import Foundation
import UIKit

class SensorTableViewController: UITableViewController {
    lazy var bleShield = (UIApplication.shared.delegate as! AppDelegate).bleShield
    var rssiTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // Set number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Set number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Construct cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if(indexPath.section == 0){
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            cell!.textLabel!.text = "Light Sensor";
        }
        if(indexPath.section == 1) {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            cell!.textLabel!.text = "Button";
        }
        return cell!
    }
}

