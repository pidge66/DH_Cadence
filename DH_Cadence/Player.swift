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
    
    func switchToSpeaker()
    {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.none)
        } catch _ {
        }
    }
    
    func playSound() {
        //if let path = Bundle.main.path(forResource: "PinkPanther30", ofType: "wav") {
        if let path = Bundle.main.path(forResource: "BachGavotteShort", ofType: "mp3") {
            // Unfortunately, this is the ONLY system sound available
            //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            do {
                if sound.isPlaying {
                    print("already playing, stop first")
                    sound.stop()
                } else {
                    print("not currently playing")
                    switchToSpeaker()
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
                try AVAudioSession.sharedInstance().setActive(false)
            } catch _ {
            }

        }
    }
}
