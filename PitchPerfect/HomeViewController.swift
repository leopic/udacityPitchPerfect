//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/10/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnMicrophone: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecordingInProgress: UILabel!
    
    var audioPlayer:AVAudioPlayer?
    
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            if let fileUrl = NSURL(fileURLWithPath: filePath) {
                var err:NSError?
                audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl, error: &err)
                audioPlayer!.prepareToPlay()
                if err != nil {
                    println(err?.localizedDescription)
                }
                audioPlayer?.enableRate = true
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        resetUI()
    }
    
    // MARK: interactions
    @IBAction func tapOnMicrophoneBtn(sender: AnyObject) {
        resetUI(toInitialState: false)
        
        if let player = audioPlayer {
            player.rate = 0.5
            player.play()
        }
    }
    
    @IBAction func tapOnStopBtn(sender: AnyObject) {
        resetUI()
        
        if let player = audioPlayer {
            player.stop()
        }
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
