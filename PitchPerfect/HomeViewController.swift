//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/10/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnMicrophone: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecordingInProgress: UILabel!
    
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        resetUI()
    }
    
    // MARK: interactions
    @IBAction func tapOnMicrophoneBtn(sender: AnyObject) {
        resetUI(toInitialState: false)
    }
    
    @IBAction func tapOnStopBtn(sender: AnyObject) {
        resetUI()
    }
    
    /**
    Util to handle multiple UI changes at once
    
    :param: toInitialState whether or not go back to the view's initial state
    */
    func resetUI(toInitialState:Bool = true) {
        lblRecordingInProgress.hidden = toInitialState
        btnStop.hidden = toInitialState
        btnMicrophone.enabled = toInitialState
    }

}
