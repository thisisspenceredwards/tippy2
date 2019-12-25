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
    var first = true
    var startTime = NSDate()
    var currency = "$"
    @IBOutlet weak var peopleController: UISegmentedControl!
    @IBOutlet weak var percentageController: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
   // func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool
    // {
    //  return true
   // }

    //func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool
    //{
     // return true
    //}
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        if(open == true)
        {
            billField.text = "$"
            billField.becomeFirstResponder()
            open = false
            defaults.set(".dark", forKey: "myInterface")
            overrideUserInterfaceStyle = .dark
           // percentageController.selectedSegmentIndex = 0
           // peopleController.selectedSegmentIndex = 0
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        let currentTime = NSDate()
        if(currentTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate > 10)
        {
            print(currentTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate)
            print("RESET")
            let reset = 0
            defaults.set(reset, forKey: "myPercent")
            defaults.set(reset, forKey: "myPeople")
            defaults.set("", forKey: "myBill")
        }
        let background = defaults.string(forKey: "myInterface")
        if(background == ".dark")
        {
             overrideUserInterfaceStyle = .dark
        }
        else
        {
             overrideUserInterfaceStyle = .light
        }
        self.billField.alpha = 0
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        //let bill = Double(billField.text!) ?? 0.0
       /* if(first == true)
        {
            print("FIRST EQUALS TRUE")
            percentageController.selectedSegmentIndex = 0
            peopleController.selectedSegmentIndex = 0
            first = false
        }*/
        percentageController.selectedSegmentIndex = defaults.integer(forKey: "myPercent")
        peopleController.selectedSegmentIndex = defaults.integer(forKey: "myPeople")
        billField.text = "$" + (defaults.string(forKey: "myBill") ?? "0")
        super.viewWillAppear(animated)
        calculateTip(self)
       /*
        super.viewWillAppear(animated)  //bad repeated code below, would make helper function if i was more familiar with swift
        if(billField.text?.isEmpty ?? true)
        {
            billField?.placeholder = currency
        }
        self.billField.alpha = 0
               self.tipLabel.alpha = 0
               self.totalLabel.alpha = 0
               let bill =
                Double(billField.text!) ?? 0.0
        if(first == true)
        {
            percentageController.selectedSegmentIndex = 0
            peopleController.selectedSegmentIndex = 0
            first = false
        }
        else
        {
               percentageController.selectedSegmentIndex = defaults.integer(forKey: "myPercent")
               peopleController.selectedSegmentIndex = defaults.integer(forKey: "myPeople")
        }
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
                           
        
                             if(bill <= 0.0)
                            {
                                
                                tipLabel.text = String(format:"$%.2f", 0.0)
                                    totalLabel.text = String(format:"$%.2f", 0.0)
                            }
                            else
                             {
                                let tip = bill * percentArray[percentage]
                                let total = (bill + tip)/Double(peopleArray[peeps])
                                print("here")
                                tipLabel.text = addCommas(val: tip)
                                totalLabel.text = addCommas(val: total)
                                billField.text = addCommas(val: bill)
                            }
    
                 */
                
    }
    func addCommas(val: Double) -> String
    {
        print("addCommas")
        var str = String(format:"%.2f",  val) //to guarantee 3 characters before the first integer value
        for n in stride(from: str.count-6, to: -1, by: -3)
        {
            if(n == 0)
            {
                break
            }
            print("for loop")
            let char = str.index(str.startIndex,offsetBy: n)
            str.insert( "," , at: str.index(str.startIndex, offsetBy: n))
            print(str[char])
        }
        print(str)
        return str
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewdidappear")
        UIView.animate(withDuration: 1.0) {
        self.billField.alpha = 1.0
        self.tipLabel.alpha = 1.0
        self.totalLabel.alpha = 1.0
        }
        
        
    }
    @IBAction func updateTime(_ sender: Any)
    {
        startTime = NSDate()
    }
    @IBAction func ontap(_ sender: Any)
    {
        print("ontap")
        view.endEditing(true)
    }
    @IBAction func percentageChanged(_ sender: Any)
    {
        print("percentageChanged")
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
        defaults.set(peeps, forKey: "myPeople")
        defaults.synchronize()
        calculateTip(sender)
    }
    @IBAction func calculateTip(_ sender: Any)
    {
       // if(billField.text!.isEmpty())
        var strBill = billField.text
        if(strBill!.first == Character(currency))
        {
            strBill = String(strBill!.dropFirst())
        }
          let bill = Double(strBill!) ?? 0.0
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
                        defaults.set(bill, forKey: "myBill")
                        defaults.synchronize()
                        tipLabel.text = "$" + addCommas(val: tip)
                        totalLabel.text = "$" + addCommas(val: total)
                        //billField.text = addCommas(val: bill)
                          // tipLabel.text = addCommas(val: tip)
                          //  totalLabel.text = String(format: "$%.2f", total)
                     }
            
            
    }
    
}
