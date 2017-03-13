//
//  DeckClassPickerViewController.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-13.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

class DeckClassPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func classPicked(_ sender: UIButton) {
        performSegue(withIdentifier: "classpicker", sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "classpicker", let destination = segue.destination as? DeckBuilderViewController {
            let button = sender as! UIButton
            NSLog("test")
            destination.pickedClass = button.currentTitle!
        }
    }

}
