//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/10/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var btnMicrophone: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecordingInProgress: UILabel!
    
    let SegueDetail = "showDetailSegue"
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    var err:NSError?
    
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        resetUI()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueDetail {
            let next:DetailViewController = segue.destinationViewController as! DetailViewController
            next.recordedAudio = recordedAudio
        }
    }
    
    // MARK: interactions
    @IBAction func tapOnMicrophoneBtn(sender: AnyObject) {
        resetUI(toInitialState: false)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let pathArray = [dirPath, "recording.wav"]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &err)
        
        if err == nil {
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: &err)
            
            if err == nil {
                audioRecorder.delegate = self
                audioRecorder.meteringEnabled = true
                audioRecorder.prepareToRecord()
                audioRecorder.record()
            } else {
                println(err?.localizedDescription)
            }
        } else {
            println(err?.localizedDescription)
        }
    }
    
    @IBAction func tapOnStopBtn(sender: AnyObject) {
        resetUI()
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: &err)
        if err != nil {
            println(err?.localizedDescription)
        }
    }
    
    // MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            recordedAudio = RecordedAudio(filePath: recorder.url, title: recorder.url.lastPathComponent!)
            performSegueWithIdentifier(SegueDetail, sender: self)
        } else {
            println("fail at recording")
        }
    }
    
    // MARK: Util
    
    /**
    Util to handle multiple UI changes at once
    
    :param: toInitialState whether or not go back to the view's initial state
    */
    func resetUI(toInitialState:Bool = true) {
        lblRecordingInProgress.text = toInitialState ? "Tap to Record" : "recording"
        btnStop.hidden = toInitialState
        btnMicrophone.enabled = toInitialState
    }

}
