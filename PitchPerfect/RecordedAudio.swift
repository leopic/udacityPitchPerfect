//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Leo Picado on 6/12/15.
//  Copyright (c) 2015 LeoPicado. All rights reserved.
//

import Foundation

// Reviewer:
// While I realize that the instructions called for a class with an initializer,
// a struct is a good replacement here that fits the bill and has a built-in
// initializer for all properties.

/**
A bit of recorded audio.
*/
struct RecordedAudio {
    var filePath:NSURL
    var title:String
}
