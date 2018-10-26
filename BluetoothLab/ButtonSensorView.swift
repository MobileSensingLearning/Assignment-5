//
//  ButtonSensorView.swift
//  BluetoothLab
//
//  Created by Brandon McFarland on 10/19/18.
//  Copyright © 2018 MobileSensingLearning. All rights reserved.
//

import Foundation
import UIKit

class ButtonSensorView: UIViewController {
    lazy var bleShield = (UIApplication.shared.delegate as! AppDelegate).bleShield
    var rssiTimer = Timer()
    var connectedTo = ""
    var transminssionArray = ["!","","&", ""]
    var shouldSendTransmission = false
    @IBOutlet weak var TransmitSwitch: UISwitch!
    @IBOutlet weak var RadioImageView: UIImageView!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    // Show radio image and toggle transmission boolean
    @IBAction func switchChanged(_ sender: Any) {
        if TransmitSwitch.isOn {
            // show the radio image
            self.RadioImageView.isHidden = false
            self.shouldSendTransmission = true
        } else {
            // hide the radio image
            self.RadioImageView.isHidden = true
            self.shouldSendTransmission = false
        }
    }
    
    // Set slider value in transmission array when slider changed
    @IBAction func sliderChanged(_ sender: UISlider) {
        self.transminssionArray[3] = String(Int(sender.value))
    }
    
    @IBOutlet weak var connectedToLabel: UILabel!
    @IBOutlet weak var rawDataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default value in transmiaaion array for slider
        transminssionArray[3] = String(Int(brightnessSlider.value))
        
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
    
    func bleDidUpdateState() {
        
    }
    
    // Connecton function
    @objc func onBLEDidConnectNotification(notification:Notification){
        print("CONNECTION NOTIFICATION")
        rssiTimer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                         repeats: true,
                                         block: self.readRSSITimer)
        self.connectedTo = notification.userInfo?["name"] as! String;
        print("CONNECTED TO: ", self.connectedTo)
    }
    
    // Data notification function
    @objc func onBLEDidRecieveDataNotification(notification:Notification){
        let d = notification.userInfo?["data"] as! Data?
        let s = String(bytes: d!, encoding: String.Encoding.utf8)
        let sArray = Array(s!)
        
        // Check that the index exists
        let isIndexValid = sArray.indices.contains(1)
        
        //UIColor(red: 108.0 / 255.0, green: 217.0 / 255.0, blue: 209.0 / 255.0, alpha: 1.0)
        if isIndexValid == true {
            let value = Int(String(sArray[1]))!
            if value == 0 {
                self.rawDataLabel.text = String(value)
                self.view.backgroundColor = UIColor(red: 46.0 / 255.0, green: 46.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
                self.transminssionArray[1] = "0"
            } else if value == 1 {
                self.rawDataLabel.text = String(value)
                self.view.backgroundColor = UIColor(red: 104.0 / 255.0, green: 99.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
                self.transminssionArray[1] = "1"
            } else {
                self.rawDataLabel.text = ""
                self.view.backgroundColor = UIColor(red: 241.0 / 255.0, green: 241.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
                self.transminssionArray[1] = ""
            }
            
        }
        
        if self.connectedTo == "" {
            self.connectedTo = notification.userInfo?["name"] as! String;
            self.connectedToLabel.text = notification.userInfo?["name"] as! String;
        }
        
        if self.shouldSendTransmission == true {
            //let transmissionString = "".join(transminssionArray)
            let transmissionString = transminssionArray.joined(separator: "")
            let d = transmissionString.data(using: String.Encoding.utf8)!
            //print("SENDING: ", transmissionString)
            bleShield.write(d)
        }
    }
    
    // Disconnect function
    @objc func onBLEDidDisconnectNotification(notification:Notification){
        print("DISCONNECTION NOTIFICATION")
    }
}


