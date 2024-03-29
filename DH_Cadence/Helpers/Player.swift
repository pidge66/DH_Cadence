//
//  Player.swift
//  DH_Cadence
//
//  Created by David Hou on 2/19/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import AVFoundation

class Player: ObservableObject {
    @Published var percentComplete: Double = 0.0
    @Published var activityIndicator: Bool = false
    private var elapsedTime: Double = 0
    private var totalTime: Double = 0
    
    private var sound = AVAudioPlayer()
    //private var cadence: Cadence
    
    // *** to enable background playing; need also to add Background Modes | Audio capability in project
    private let audioSession = AVAudioSession.sharedInstance()
    
    private var cadence: Cadence?
    private var currentIteriation = 0
    private var currentMetronomeIndex = 0
    private var currentRepetiion = 0
    private var myTimer: Timer?
    private var active = false
    private var paused = false
    


    init() {
        setupAudioSession()
    }
    
    deinit {
        stopSound()
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
                }
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                sound.prepareToPlay()
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
        timer.invalidate()
        guard let r = cadence?.repetitions else {return}
        guard let m = cadence?.metronomes else {return}
        if !active {return}
        if m.count <= 0 {return}
        
        playSound(m[currentMetronomeIndex].tone)
        
        currentRepetiion += 1
        if currentRepetiion >= m[currentMetronomeIndex].repetitions {
            currentRepetiion = 0
            currentMetronomeIndex += 1
            if currentMetronomeIndex >= m.count {
                currentMetronomeIndex = 0
                currentIteriation += 1
                if currentIteriation >= r {
                    elapsedTime = totalTime
                    percentComplete = 100
                    activityIndicator = false
                    return
                }
            }
        }
        let tsec = m[currentMetronomeIndex].duration
        elapsedTime += tsec
        percentComplete = elapsedTime / totalTime * 100
        activityIndicator = percentComplete > 0 && percentComplete < 100
        print("Elapsed Time: \(elapsedTime)      percentComplet: \(percentComplete)")
        myTimer = Timer.scheduledTimer(timeInterval: tsec, target: self, selector: #selector(nextBeat), userInfo: nil, repeats: true)
    }
    
    func playCadence(_ myCadence: Cadence) {
        if active {
            //stopCadence()
            pauseCadence()
            print("Already active")
            return
        }
        if !paused {
            paused = false

            cadence = myCadence
            currentIteriation = 0
            currentMetronomeIndex = 0
            currentRepetiion = 0
            elapsedTime = 0
            var t: Double
            t = 0
            myCadence.metronomes.forEach({
                t += $0.duration * Double($0.repetitions)
                print("\($0) = \(t)")
            })
            print("totalTime: \(t * Double(myCadence.repetitions))")
            self.totalTime = t * Double(myCadence.repetitions)
        }
        // short preamble to kick off the "nextBeat" to start the cadence
        myTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(nextBeat), userInfo: nil, repeats: false)
        
        active = true
    }
    
    func pauseCadence() {
        active = false
        paused = true
        stopSound()
    }
    
    func stopCadence() {
        active = false
        paused = false
        stopSound()
        percentComplete = 0
        activityIndicator = false
    }
}
