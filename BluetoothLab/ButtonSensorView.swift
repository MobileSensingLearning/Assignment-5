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
    @IBOutlet weak var TransmitSwitch: UISwitch!
    @IBOutlet weak var RadioImageView: UIImageView!
    @IBAction func switchChanged(_ sender: Any) {
        if TransmitSwitch.isOn {
            // show the radio image
            self.RadioImageView.isHidden = false
        } else {
            // hide the radio image
            self.RadioImageView.isHidden = true
        }
    }
}


