//
//  LightSensorView.swift
//  BluetoothLab
//
//  Created by Brandon McFarland on 10/19/18.
//  Copyright © 2018 MobileSensingLearning. All rights reserved.
//

import Foundation
import UIKit

class LightSensorView: UIViewController {
    lazy var bleShield = (UIApplication.shared.delegate as! AppDelegate).bleShield
    var rssiTimer = Timer()
    var connectedTo = ""    
    @IBOutlet weak var rawDataLabel: UILabel!
    @IBOutlet weak var connectedToLabel: UILabel!
    @IBOutlet weak var brightnessSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // BLE Connect Notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onBLEDidConnectNotification),
                                               name: NSNotification.Name(rawValue: kBleConnectNotification),
                                               object: nil)
        
        
        // BLE Recieve Data Notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onBLEDidRecieveDataNotification),
                                               name: NSNotification.Name(rawValue: kBleReceivedDataNotification),
                                               object: nil)
        
        // BLE Disconnect Notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.onBLEDidDisconnectNotification),
                                               name: NSNotification.Name(rawValue: kBleDisconnectNotification),
                                               object: nil)
    }
    
    func readRSSITimer(timer:Timer){
        // Does nothing now
    }
    
    // Connecton function
    @objc func onBLEDidConnectNotification(notification:Notification){
        print("CONNECTION NOTIFICATION")
        rssiTimer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                         repeats: true,
                                         block: self.readRSSITimer)
        self.connectedTo = notification.userInfo?["name"] as! String;
    }
    
    // Data notification function
    @objc func onBLEDidRecieveDataNotification(notification:Notification){
        let d = notification.userInfo?["data"] as! Data?
        let s = String(bytes: d!, encoding: String.Encoding.utf8)
        
        let sArray = Array(s!)
        
        // Check that the index exists
        let isIndexValid = sArray.indices.contains(3)

        if isIndexValid == true {
            let value = Int(String(sArray[3]))!
            self.rawDataLabel.text = String(sArray[3])
            if value < 4 {
                brightnessSegmentedControl.selectedSegmentIndex = 0
            } else if value > 3 && value < 7 {
                brightnessSegmentedControl.selectedSegmentIndex = 1
            } else if value > 6 && value < 10 {
                brightnessSegmentedControl.selectedSegmentIndex = 2
            }
        } else {
            self.rawDataLabel.text = ""
        }
        
        if self.connectedTo == "" {
            self.connectedTo = notification.userInfo?["name"] as! String;
            self.connectedToLabel.text = notification.userInfo?["name"] as! String;
        }
    }
    
    // Disconnect function
    @objc func onBLEDidDisconnectNotification(notification:Notification){
        print("DISCONNECTION NOTIFICATION")
    }

    
}
