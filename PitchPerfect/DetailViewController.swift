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
    @IBOutlet weak var btnStop: UIButton!
    
    var audioPlayer:AVAudioPlayer?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            if let fileUrl = NSURL(fileURLWithPath: filePath) {
                var err:NSError?
                audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl, error: &err)
                if var player = audioPlayer {
                    player.enableRate = true
                    player.prepareToPlay()
                    if err != nil {
                        println(err?.localizedDescription)
                    }
                }
            }
        }
    }

    // MARK: Interactions
    @IBAction func tapOnSlowBtn(sender: AnyObject) {
        playSound(atRate: 0.5)
    }

    @IBAction func tapOnFastBtn(sender: AnyObject) {
        playSound(atRate: 2.0)
    }
    
    @IBAction func tapOnHighPitchedBtn(sender: AnyObject) {
        
    }
    
    @IBAction func tapOnLowPitchedBtn(sender: AnyObject) {
        
    }
    
    @IBAction func tapOnStopBtn(sender: AnyObject) {
        if let player = audioPlayer {
            player.stop()
        }
    }
    
    func playSound(atRate:Float = 1.0) {
        if let player = audioPlayer {
            player.stop()
            player.rate = atRate
            player.currentTime = NSTimeInterval(0.0)
            player.play()
        }
    }

}
