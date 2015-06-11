//
//  DetailViewController.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/10/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var btnSlow: UIButton!
    @IBOutlet weak var btnFast: UIButton!
    @IBOutlet weak var btnHighPitched: UIButton!
    @IBOutlet weak var btnLowPitched: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapOnSlowBtn(sender: AnyObject) {
    }

    @IBAction func tapOnFastBtn(sender: AnyObject) {
    }
    
    @IBAction func tapOnHighPitchedBtn(sender: AnyObject) {
    }
    
    @IBAction func tapOnLowPitchedBtn(sender: AnyObject) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
