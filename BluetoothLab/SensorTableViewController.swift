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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // HARD CODEED
        //return self.bleShield.peripherals.count
        return 1
    }
    
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

