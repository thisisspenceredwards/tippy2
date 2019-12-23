//
//  Settings.swift
//  tippy2
//
//  Created by Spencer on 12/22/19.
//  Copyright © 2019 Spencer. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    let defaults = UserDefaults.standard
   
    //@IBOutlet weak var percentageController: UISegmentedControl!
    //  @IBOutlet weak var test: UISegmentedControl!
    
    @IBOutlet weak var percentageController: UISegmentedControl!
   
    @IBOutlet weak var peopleController: UISegmentedControl!
    //  @IBOutlet weak var percentageController: UISegmentedControl!
    // @IBOutlet weak var percentageController: UISegmentedControl!
   // @IBOutlet weak var peopleController: UISegmentedControl!
    //let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        percentageController.selectedSegmentIndex = defaults.integer(forKey: "myPercent")
        peopleController.selectedSegmentIndex = defaults.integer(forKey: "myPeople")
    }
    @IBAction func percentageChanged(_ sender: Any)
    {
        let seg = percentageController.selectedSegmentIndex
        defaults.set(seg, forKey: "myPercent")
        defaults.synchronize()
    }

    @IBAction func peopleChanged(_ sender: Any)
    {
        let peeps = peopleController.selectedSegmentIndex
        print("this is bo peep")
        print(peeps)
        defaults.set(peeps, forKey: "myPeople")
        defaults.synchronize()
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
