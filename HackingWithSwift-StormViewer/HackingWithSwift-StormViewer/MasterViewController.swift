//
//  MasterViewController.swift
//  HackingWithSwift-StormViewer
//
//  Created by Vibin Nair on 06/07/15.
//  Copyright (c) 2015 Morningstar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [String]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = NSFileManager.defaultManager()
        if let path = NSBundle.mainBundle().resourcePath {
            if let items = fileManager.contentsOfDirectoryAtPath(path, error: nil) {
                objects = items.filter({$0.hasPrefix("nssl")}) as! [String]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.detailItem = objects[indexPath.row]
            }
        }
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

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

}

