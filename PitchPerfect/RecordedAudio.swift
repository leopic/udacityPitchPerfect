//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/12/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import Foundation

/**
A bit of recorded audio.
*/
class RecordedAudio {
    var filePath:NSURL!
    var title:String!
    
    init(filePath:NSURL, title:String) {
        self.filePath = filePath
        self.title = title
    }
}
