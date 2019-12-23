//
//  ViewController.swift
//  tippy2
//
//  Created by Spencer on 12/19/19.
//  Copyright © 2019 Spencer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberOfPeopleController: UISegmentedControl!
    @IBOutlet weak var tipControl: UISegmentedControl!
    // @IBOutlet weak var numberOfPeopleController: UISegmentedControl!
   // @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Show keyboard by default
        
    }
    @IBAction func ontap(_ sender: Any)
    {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any)
    {
        let bill = Double(billField.text!) ?? 0.0
        if(bill <= 0.0)
        {
            tipLabel.text = String(format:"$%.2f", 0.0)
            totalLabel.text = String(format:"$%.2f", 0.0)
        }
        else
        {
            let percentArray = [0.1, 0.15, 0.2, 0.25]
            let peopleArray = [ 1, 2, 3, 4, 5, 6, 7, 8,]
            let percentage = percentArray[tipControl.selectedSegmentIndex]
            let peeps = Double(peopleArray[numberOfPeopleController.selectedSegmentIndex])
            
            //let defaults = UserDefaults.standard
            //var percentage = defaults.double(forKey: "myPercent")
            //if(percentage == 0.0) {percentage = 0.10}
            //var peeps = Double(defaults.integer(forKey: "myPeople"))
            //if(peeps == 0) {peeps = 1}
            
            let tip = bill * percentage
            let total = (bill + tip)/peeps
            
            tipLabel.text = String(format:"$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
    }
}

