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
    //private var cadence: Cadence
    
    // *** to enable background playing; need also to add Background Modes | Audio capability in project
    private let audioSession = AVAudioSession.sharedInstance()
    
    private var cadence: Cadence?
    private var currentMetronomeIndex = 0
    private var currentRepetiionCount = 0
    private var myTimer: Timer?


    init() {
        setupAudioSession()
    }
    
    deinit {
        stopSound()
        //print("deinit Player")
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
                    //sound.stop()
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
    
    @objc func nextBeat (timer: Timer) {
        guard let m = cadence?.metronomes else {return}
        print("metronomes in nextBeat: \(m)")
        timer.invalidate()
        
        playSound(m[currentMetronomeIndex].tone)
        currentRepetiionCount += 1
        if currentRepetiionCount >= m[currentMetronomeIndex].repetitions {
            currentMetronomeIndex += 1
            if currentMetronomeIndex < m.count {
                currentRepetiionCount = 0
            } else {
                stopSound()
                return
            }
        }
        let tsec = m[currentMetronomeIndex].tempo/60
        myTimer = Timer.scheduledTimer(timeInterval: tsec, target: self, selector: #selector(nextBeat), userInfo: nil, repeats: true)
    }
    
    func playCadence(_ myCadence: Cadence) {
        cadence = myCadence
        currentMetronomeIndex = 0
        currentRepetiionCount = 0
        cadence?.metronomes.forEach {
            print("\($0)")
        }
        
        // 1 sec preamble to kick it off before starting the cadence
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(nextBeat), userInfo: nil, repeats: false)

    }
}
