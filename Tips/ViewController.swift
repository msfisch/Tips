//
//  ViewController.swift
//  Tips
//
//  Created by Chelsea Fischbach on 9/23/16.
//  Copyright © 2016 Chelsea Fischbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var roundingSwitch: UISwitch!
    @IBOutlet weak var effTipLabel: UILabel!
    @IBOutlet weak var effTipView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.becomeFirstResponder()
        self.effTipView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let getChange = (bill + tip) * 100
        let diffChange = getChange.truncatingRemainder(dividingBy: 100)
        let round = (100 - diffChange) / 100
        
        if roundingSwitch.isOn {
            
            UIView.animate(withDuration: 0.4, animations: {
                self.effTipView.alpha = 1
            })
            
            let tipFinal = tip + round
            let total = bill + tipFinal
            let effTipPercent = tipFinal * 100 / bill
            
            tipLabel.text = String(format: "$%.2f", tipFinal)
            totalLabel.text = String(format: "$%.2f", total)
            effTipLabel.text = String(format: "%.0f%%", effTipPercent)
            
        } else {
            
            UIView.animate(withDuration: 0.4, animations: {
                self.effTipView.alpha = 0
            })
            
            let tipFinal = tip
            let total = bill + tipFinal
            
            tipLabel.text = String(format: "$%.2f", tipFinal)
            totalLabel.text = String(format: "$%.2f", total)
            effTipLabel.text = String(format: "%.0f%%", tipFinal)
        }
        
    }

}

