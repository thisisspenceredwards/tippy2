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
    var dividerSymbol = ","
    var originalHeight = CGFloat(0.0)
    var billLength = 0
    @IBOutlet weak var peopleController: UISegmentedControl!
    @IBOutlet weak var percentageController: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    //@IBOutlet weak var navigationBar: UINavigationController!
    //@IBOutlet var peopleControllerYconstraint: NSLayoutConstraint!
    //@IBOutlet var percentageControllerYconstraint: NSLayoutConstraint!
    @IBOutlet var billFieldHeightconstraint: NSLayoutConstraint!
    //@IBOutlet var tipYconstraint: NSLayoutConstraint!
    //@IBOutlet var totalYconstraint: NSLayoutConstraint!
    

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
        }
    }
  

    func formatBill(val: String)
    {
        let length = val.count
        var index = 0
        for n in val
        {
            if(String(n) == ".")
            {
                break
            }
             index+=1
        }
        var integer = val.prefix(index)
        for n in stride(from: index-3, to: -1, by: -3)
        {
            if(n == 0)
            {
                break
            }
            integer.insert( "," , at: integer.index(integer.startIndex, offsetBy: n))
        }
        let double = val.suffix(length - index)
        let strBill = "$" + integer + double
        billField.text = strBill
    }
 
    @IBAction func animation(_ sender: Any)
    {
        let lengthOfBillText = String(billField.text ?? "").count
    print("HERE")
        if(self.billLength != lengthOfBillText && self.billFieldHeightconstraint.constant != self.originalHeight)
        {
            self.billLength = lengthOfBillText
           // UIView.animate(withDuration: 1.0, options: [.curveEaseOut])
            UIView.animate(withDuration: 1.0)
            {
                self.billFieldHeightconstraint.constant = self.originalHeight
                self.view.layoutIfNeeded()
            }
        }
        
    
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.originalHeight = billFieldHeightconstraint.constant
        billFieldHeightconstraint.constant = view.bounds.height - billFieldHeightconstraint.constant
        
     //   billField.constant -= view.bounds.width
     //   usernameTextFieldCenterConstraint.constant -= view.bounds.width
     //   passwordTextFieldCenterConstraint.constant -= view.bounds.width
        let currentTime = NSDate()
        print("time and stuff")
         print(currentTime.timeIntervalSinceReferenceDate - startTime.timeIntervalSinceReferenceDate)
        
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
        percentageController.selectedSegmentIndex = defaults.integer(forKey: "myPercent")
        peopleController.selectedSegmentIndex = defaults.integer(forKey: "myPeople")
        print("this is defaults.string" + (defaults.string(forKey: "myBill") ?? "0"))
        let double = defaults.double(forKey:"myBill")
        print("this is double: " + String(double))
        billField.text = "$" + (defaults.string(forKey: "myBill") ?? "")
        super.viewWillAppear(animated)
        calculateTip(self)
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
    func removeDenomination(val: String) -> String
    {
        if(val.first == Character(currency))
        {
            return String(val.dropFirst())
        }
        return val
        
    }
    func removeCommas(val: String) -> String
    {
        return val.replacingOccurrences(of: ",", with: "")
    }
    
    
    
    
    @IBAction func calculateTip(_ sender: Any)
    {
        
        var strBill = removeDenomination(val: billField.text!)
        strBill = removeCommas(val: strBill)
        formatBill(val: strBill)
        let bill = Double(strBill) ?? 0.0
        
            if(bill <= 0.0)
            {
                tipLabel.text = String(format:"$%.2f", 0.0)
                totalLabel.text = String(format:"$%.2f", 0.0)
                defaults.set("", forKey: "myBill")
            }
            else
            {
               defaults.set(strBill, forKey: "myBill")
                let defaults = UserDefaults.standard
                let percentArray = [0.1, 0.15, 0.2, 0.25]
                let peopleArray = [ 1, 2, 3, 4, 5, 6, 7, 8,]
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
                    peeps = defaults.integer(forKey: "myPeople")
                }
                let tip = bill * percentArray[percentage]
                let total = (bill + tip)/Double(peopleArray[peeps])
                defaults.set(bill, forKey: "myBill")
                defaults.synchronize()
                tipLabel.text = "$" + addCommas(val: tip)
                totalLabel.text = "$" + addCommas(val: total)
                }
    }
    
}
