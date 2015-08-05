//
//  MasterViewController.swift
//  HackingWithSwift-Anagrams
//
//  Created by Vibin Nair on 24/07/15.
//  Copyright (c) 2015 Morningstar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "promptForAnswer")
        
        if let wordsFilePath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
            if let startingWords = NSString(contentsOfFile: wordsFilePath, usedEncoding: nil, error: nil) {
                allWords = startingWords.componentsSeparatedByString("\n") as! [String]
            }
        }
        else {
            allWords = ["silkworm"]
        }
        
        startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }
    
    func startGame() {
        allWords.shuffle()
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) {[weak self, alertController] _ in
            let answer = alertController.textFields![0] as! UITextField
                 self?.submitAnswer(answer.text)
        }
        
        alertController.addAction(submitAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func submitAnswer(answer: String) {
        let lowerAnswer = answer.lowercaseString
        
        if wordIsPossible(lowerAnswer) {
            if wordHasNeverBeenUsedBefore(lowerAnswer) {
                if wordIsReal(lowerAnswer) {
                    objects.insert(lowerAnswer, atIndex: 0)
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                } else {
                    showErrorAlert("Word is not real", message: "You can't just make them up, you know!")
                }
            } else {
                showErrorAlert("Word used already", message: "Be more original!")
            }
        } else {
            showErrorAlert("Word not possible", message: "You can't spell that word from '\(title!.lowercaseString)'!")
        }
    }
    
    func wordIsPossible(word: String) -> Bool {
        var tempWord = title!.lowercaseString
        
        for letter in word {
            if let position = tempWord.rangeOfString(String(letter)) { // Converting a character to string object
                if position.isEmpty {
                    return false
                }
                else {
                    tempWord.removeAtIndex(position.startIndex)
                }
            }
            else {
                return false
            }
        }
        
        return true
    }
    
    func wordIsReal(word: NSString) -> Bool {
        let checker = UITextChecker()
        
        let range = NSMakeRange(0, word.length)
        
        let misspelledRange = checker.rangeOfMisspelledWordInString(word as String, range: range, startingAt: 0, wrap: false, language: "en")
    
        return misspelledRange.location == NSNotFound
    }
    
    func wordHasNeverBeenUsedBefore(word: String) -> Bool {
        return !contains(objects, word)
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

