//
//  DetailViewController.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/10/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var btnSlow: UIButton!
    @IBOutlet weak var btnFast: UIButton!
    @IBOutlet weak var btnHighPitched: UIButton!
    @IBOutlet weak var btnLowPitched: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    var recordedAudio:RecordedAudio!
    var audioPlayer:AVAudioPlayer?
    var audioEngine = AVAudioEngine()
    var err:NSError?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePath, error: &err)
        if let player = audioPlayer {
            if err == nil {
                player.delegate = self
                player.enableRate = true
                player.prepareToPlay()
            } else {
                println(err?.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        postPlay()
    }
    
    // MARK: Interactions
    @IBAction func tapOnSlowBtn(sender: AnyObject) {
        playSound(atRate: 0.5)
    }
    
    @IBAction func tapOnFastBtn(sender: AnyObject) {
        playSound(atRate: 2.0)
    }
    
    @IBAction func tapOnHighPitchedBtn(sender: AnyObject) {
        playSound(atPitch: 2400)
    }
    
    @IBAction func tapOnLowPitchedBtn(sender: AnyObject) {
        playSound(atPitch: -1200)
    }
    
    @IBAction func tapOnStopBtn(sender: AnyObject) {
        stopSound()
    }
    
    // MARK: AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        postPlay()
    }
    
    // MARK: Util
    
    /**
    Play the current audio file at a given pitch.
    
    :param: atPitch The amount by which the input signal is pitch shifted.
    */
    func playSound(atPitch:Float = 0) {
        if let player = audioPlayer {
            prePlay()
            
            var pitchPlayer = AVAudioPlayerNode()
            var timePitch = AVAudioUnitTimePitch()
            timePitch.pitch = atPitch
            
            audioEngine.attachNode(pitchPlayer)
            audioEngine.attachNode(timePitch)
            
            audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
            audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
            
            pitchPlayer.scheduleFile(AVAudioFile(forReading: recordedAudio.filePath, error: &err), atTime: nil, completionHandler: {
                // Reviewer: this feels like it's out of sync
                // this is called before the audio stops playing
                dispatch_async(dispatch_get_main_queue(), {
                    self.btnStop.hidden = true
                    return
                })
            })
            
            if err == nil {
                audioEngine.startAndReturnError(&err)
                
                if err == nil {
                    pitchPlayer.play()
                } else {
                    println(err?.localizedDescription)
                }
            } else {
                println(err?.localizedDescription)
            }
            
        }
    }
    
    /**
    Play the current audio file at a given rate.
    
    :param: atRate The audio player’s playback rate.
    */
    func playSound(atRate:Float = 1.0) {
        if let player = audioPlayer {
            prePlay()
            player.rate = atRate
            player.play()
        }
    }
    
    /**
    Stops sounds from both audio player and audio engine.
    */
    func stopSound() {
        btnStop.hidden = true
        audioEngine.stop()
        audioPlayer?.stop()
    }

    /**
    Reset players to initial values.
    */
    func prePlay() {
        if let player = audioPlayer {
            stopSound()
            audioEngine.reset()
            player.currentTime = NSTimeInterval(0.0)
            btnStop.hidden = false
        }
    }
    
    /**
    Called after a recording has finished.
    */
    func postPlay() {
        btnStop.hidden = true
    }
    
}
