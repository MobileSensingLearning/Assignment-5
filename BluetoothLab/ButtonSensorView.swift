//
//  ButtonSensorView.swift
//  BluetoothLab
//
//  Created by Brandon McFarland on 10/19/18.
//  Copyright © 2018 MobileSensingLearning. All rights reserved.
//

import Foundation
import UIKit

var gradientLayer: CAGradientLayer!

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
    
    
//    func switchIsChanged(TransmitSwitch: UISwitch) {
//        if TransmitSwitch.isOn {
//            // show the radio image
//            self.RadioImageView.isHidden = false
//        } else {
//            // hide the radio image
//            self.RadioImageView.isHidden = true
//        }
//    }
    
}





//    func createGradientLayer() {
//        gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [ UIColor(red: 35.0 / 255.0, green: 29.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 95.0 / 255.0, green: 88.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        createGradientLayer()
//    }


