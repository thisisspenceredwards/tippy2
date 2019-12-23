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
    @IBOutlet weak var percentageController2: UISegmentedControl!
    @IBOutlet weak var peopleController2: UISegmentedControl!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        percentageController2.selectedSegmentIndex = defaults.integer(forKey: "myPercent")
        peopleController2.selectedSegmentIndex = defaults.integer(forKey: "myPeople")
    }
    @IBAction func percentageChanged2(_ sender: Any)
    {
        let seg = percentageController2.selectedSegmentIndex
        defaults.set(seg, forKey: "myPercent")
        defaults.synchronize()
    }
   
    @IBAction func peopleChanged2(_ sender: Any)
    {
        let peeps = peopleController2.selectedSegmentIndex
        print("this is bo peep")
        print(peeps)
        defaults.set(peeps, forKey: "myPeople")
        defaults.synchronize()
    }

   
   
     
     //dismiss(animated: false, completion: nil)
      //   performSegue(withIdentifier: "mainSegue", sender: nil)
    }
 //*/
    /*
    // MARK: - Navigation
     @IBAction func goBack(_ sender: Any) {
     }
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


