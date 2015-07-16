//
//  DetailViewController.swift
//  HackingWithSwift-StormViewer
//
//  Created by Vibin Nair on 06/07/15.
//  Copyright (c) 2015 Morningstar. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

   
    @IBOutlet weak var detailImageView: UIImageView!


    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let imageView = detailImageView {
                imageView.image = UIImage(named: detail)
                self.title = detail
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
           
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareTapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func shareTapped() {
        /*let activityViewController = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
        presentViewController(activityViewController, animated: true, completion: nil)*/
        
        let socialSharingViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        socialSharingViewController.setInitialText("Look at this picture")
        socialSharingViewController.addImage(detailImageView.image!)
        socialSharingViewController.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        presentViewController(socialSharingViewController, animated: true, completion: nil)
    }
}

