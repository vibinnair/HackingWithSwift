//
//  ViewController.swift
//  HackingWithSwift-GuessTheFlag
//
//  Created by Vibin Nair on 10/07/15.
//  Copyright (c) 2015 Morningstar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLbl: UILabel!
 
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        //let orangeColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).CGColor
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        askQuestion(nil)
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        correctAnswer = Int(arc4random_uniform(3)) //create a new Int using the generated UInt32 value.
        title = countries[correctAnswer].uppercaseString;
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            ++score
        } else {
            title = "Wrong"
            --score
        }
        
        let message = "Your score is \(score)."
        scoreLbl.text = message
        askQuestion(nil)
        
        //let alertController = UIAlertController(title: title, message:message, preferredStyle: .Alert)
        //alertController.addAction(UIAlertAction(title:"Continue", style: .Default, handler: askQuestion))
        //presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

