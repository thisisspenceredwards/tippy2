//
//  ViewController.swift
//  tippy2
//
//  Created by Spencer on 12/19/19.
//  Copyright © 2019 Spencer. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
      let defaults = UserDefaults.standard
      var startPercent = true
      var startPerson = true
      var open = true
    @IBOutlet weak var peopleController: UISegmentedControl!
    @IBOutlet weak var percentageController: UISegmentedControl!
    // @IBOutlet weak var numberOfPeopleController: UISegmentedControl!
   // @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if(open == true)
        {
            billField.becomeFirstResponder()
            open = false
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        print("hereO")
        super.viewWillAppear(animated)  //bad repeated code below, would make helper function if i was more familiar with swift
               self.billField.alpha = 0
               self.tipLabel.alpha = 0
               self.totalLabel.alpha = 0
               let bill = Double(billField.text!) ?? 0.0
                               if(bill <= 0.0)
                               {
                                   tipLabel.text = String(format:"$%.2f", 0.0)
                                   totalLabel.text = String(format:"$%.2f", 0.0)
                               }
                               else
                               {
                               let defaults = UserDefaults.standard
                               let percentArray = [0.1, 0.15, 0.2, 0.25]
                               let peopleArray = [ 1, 2, 3, 4, 5, 6, 7, 8,]
                               //let percentage = percentArray[tipControl.selectedSegmentIndex]
                               //let peeps = Double(peopleArray[numberOfPeopleController.selectedSegmentIndex])
                              var percentage = 0
                              var peeps = 0
                                
                                percentage = defaults.integer(forKey: "myPercent")
                                print("percentage:")
                                print(percentage)
                                peeps = defaults.integer(forKey: "myPeople")
                                print("this is first peep")
                                print(peeps)
                             
                             let tip = bill * percentArray[percentage]
                             let total = (bill + tip)/Double(peopleArray[peeps])
                             tipLabel.text = String(format:"$%.2f", tip)
                             totalLabel.text = String(format: "$%.2f", total)
        }
                
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0) {
        self.billField.alpha = 1.0
        self.tipLabel.alpha = 1.0
        self.totalLabel.alpha = 1.0
        }
        billField.becomeFirstResponder()
        // Show keyboard by default
        
    }
    @IBAction func ontap(_ sender: Any)
    {
        view.endEditing(true)
    }
    @IBAction func percentageChanged(_ sender: Any)
    {
        startPercent = false
        let seg = percentageController.selectedSegmentIndex
        defaults.set(seg, forKey: "myPercent")
        defaults.synchronize()
        calculateTip(sender)
    }

    @IBAction func peopleChanged(_ sender: Any)
    {
        startPerson = false
        let peeps = peopleController.selectedSegmentIndex
        print("this is bo peep")
        print(peeps)
        defaults.set(peeps, forKey: "myPeople")
        defaults.synchronize()
        calculateTip(sender)
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
                          let defaults = UserDefaults.standard
                          let percentArray = [0.1, 0.15, 0.2, 0.25]
                          let peopleArray = [ 1, 2, 3, 4, 5, 6, 7, 8,]
                          //let percentage = percentArray[tipControl.selectedSegmentIndex]
                          //let peeps = Double(peopleArray[numberOfPeopleController.selectedSegmentIndex])
                         var percentage = 0
                         var peeps = 0
                        if(startPerson == true)
                        {
                            startPerson = false
                            
                            defaults.set(peeps, forKey: "myPeople")
                        }
                        else if(startPercent == true)
                        {
                            startPercent = false
                            defaults.set(percentage, forKey: "myPercent")
                        }
                        else
                        {
                           percentage = defaults.integer(forKey: "myPercent")
                           print("percentage:")
                           print(percentage)
                           peeps = defaults.integer(forKey: "myPeople")
                           print("this is first peep")
                           print(peeps)
                        }
                        let tip = bill * percentArray[percentage]
                        let total = (bill + tip)/Double(peopleArray[peeps])
                        tipLabel.text = String(format:"$%.2f", tip)
                        totalLabel.text = String(format: "$%.2f", total)
                     }
            
            
        }
    
    /*
        @IBAction func startFade(_ sender: AnyObject) {

            label.alpha = 0.0

            // fade in
            UIView.animate(withDuration: 2.0, animations: {
                label.alpha = 1.0
            }) { (finished) in
                // fade out
                UIView.animate(withDuration: 2.0, animations: {
                    label.alpha = 0.0
                })
            }
 
        }
*/
}

