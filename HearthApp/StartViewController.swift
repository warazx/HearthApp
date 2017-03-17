//
//  StartViewController.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-09.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var manaSliderValue: UILabel!
    var manaCostFilterValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackground()
        
        //self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goToSetCollection(_ sender: UIButton) {
        performSegue(withIdentifier: "setCollection", sender: sender)
    }
    
    @IBAction func searchForCards(_ sender: UITextField) {
        performSegue(withIdentifier: "searchAll", sender: sender)
    }

    @IBAction func goToClassCollection(_ sender: UIButton) {
        performSegue(withIdentifier: "classCollection", sender: sender)
    }
    
    @IBAction func manaSlider(_ sender: UISlider) {
        let manaValue = Int(sender.value)
        var manaText = ""
        
        if manaValue >= 0 {
            manaText = "\(manaValue)"
            manaCostFilterValue = manaValue
        } else {
            manaText = "Off"
            manaCostFilterValue = nil
        }
        
        manaSliderValue.text = manaText
    }
    
    func loadBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background.jpg")?.draw(in: self.view.bounds)
        let bgImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: bgImage)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchAll", let destination = segue.destination as? CardCollectionViewController {
            destination.searchText = searchTextField.text!
            destination.mode = .Search
        }
        if segue.identifier == "classCollection", let destination = segue.destination as? CardCollectionViewController {
            let button = sender as! UIButton
            destination.searchText = (button.titleLabel?.text)!
            destination.mode = .Class
            destination.manaCost = manaCostFilterValue
        }
        if segue.identifier == "setCollection", let destination = segue.destination as? CardCollectionViewController {
            let button = sender as! UIButton
            destination.searchText = (button.titleLabel?.text)!
            destination.mode = .Set
            destination.manaCost = manaCostFilterValue
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
