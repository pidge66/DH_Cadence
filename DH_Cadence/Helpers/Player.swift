//
//  Player.swift
//  DH_Cadence
//
//  Created by David Hou on 2/19/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import AVFoundation

class Player {
    private var sound = AVAudioPlayer()
    private let audioSession = AVAudioSession.sharedInstance()  // to enable background playing

    init() {
        setupAudioSession()
    }
    
    deinit {
        stopSound()
        print("deinit Player")
    }
    
    func setupAudioSession()
    {
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            //try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch _ {
            print( "Error setting audio session category")
        }
        do {
            try audioSession.setActive(true)
        } catch _ {
            print( "Error activating audio session category")
        }
        // *** Switch to speaker
        do {
            //try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
        } catch _ {
            print( "Error overriding audio session port to speaker")
        }
    }
    
    func playSound(_ soundFile: String) {
        //if let path = Bundle.main.path(forResource: "PinkPanther30", ofType: "wav") {
        if let path = Bundle.main.path(forResource: soundFile, ofType: nil) {
            
            // *** Unfortunately, this is the ONLY system sound available
            //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            do {
                if sound.isPlaying {
                    print("already playing, stop first")
                    sound.stop()
                } else {
                    print("not currently playing")
                }
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                sound.prepareToPlay()
                print("Playing sound")
                sound.play()
                
            } catch {
                print( "Error playing sound")
            }
            
        } else {
            print( "Could not find file")
        }
    }
    
    func stopSound() {
        if sound.isPlaying {
            sound.stop()
            do {
                try audioSession.setActive(false)
            } catch _ {
                print( "Error stopping audio session")
            }
        }
    }
}
