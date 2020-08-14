//
//  Cadence.swift
//  DH_Cadence
//
//  Created by David Hou on 2/10/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


struct Metronome : Identifiable {
    public var id = UUID()
    var tone: String
    var selectedToneIndex: Int
    var tempo: Double
    var repetitions: Int
}

struct Cadence : Identifiable {//}, Equatable {
    public var id = UUID()
    var name: String = ""
    var repetitions: Int = 0
    var metronomes: [Metronome] = []
    
}

class ArrayCadences: ObservableObject {
    
    @Published var cadences: [Cadence]
    static let tones = [
        "silence.mp3",  //0
        "250Hz.mp3",
        "440Hz.mp3",
        "1000Hz.mp3",
        "Beep.mp3",
        "Slap.mp3",
        "Gong1.mp3",
        "Gong2.mp3",
        "Gong3.mp3",
        "Chime1.mp3",
        "Ding.mp3",     // 10
        "Beep1.mp3",
        "Beep2.mp3",
        "Beep3.mp3",
        "Beep4.mp3",
        "Gun1.mp3",
        "Gun2.mp3",
        "Gun3.mp3",
        "AirHorn.mp3"   //18
]
    static let tempos = [30.0, 60.0, 120.0, 240.0, 480.0]

    init() {
        self.cadences = [
            Cadence(name: "478 Breathing Technique", repetitions: 10, metronomes: [
                Metronome(tone: ArrayCadences.tones[2], selectedToneIndex:2, tempo: 60.0, repetitions: 3),
                Metronome(tone: ArrayCadences.tones[5], selectedToneIndex:5, tempo: 60.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[4], selectedToneIndex:4, tempo: 60.0, repetitions: 6),
                Metronome(tone: ArrayCadences.tones[5], selectedToneIndex:5, tempo: 60.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[8], selectedToneIndex:8, tempo: 60.0, repetitions: 7),
                Metronome(tone: ArrayCadences.tones[5], selectedToneIndex:5, tempo: 60.0, repetitions: 1)
            ]),
            Cadence(name: "Dumb Bell Workout", repetitions: 8, metronomes: [
                Metronome(tone: ArrayCadences.tones[2], selectedToneIndex:2, tempo: 60.0, repetitions: 3),
                Metronome(tone: ArrayCadences.tones[11], selectedToneIndex:11, tempo: 60.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[0], selectedToneIndex:0, tempo: 60.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[5], selectedToneIndex:5, tempo: 300.0, repetitions: 7),
                Metronome(tone: ArrayCadences.tones[9], selectedToneIndex:9, tempo: 300.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[0], selectedToneIndex:0, tempo: 300.0, repetitions: 3),

                Metronome(tone: ArrayCadences.tones[2], selectedToneIndex:2, tempo: 60.0, repetitions: 3),
                Metronome(tone: ArrayCadences.tones[11], selectedToneIndex:11, tempo: 60.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[0], selectedToneIndex:0, tempo: 60.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[5], selectedToneIndex:5, tempo: 300.0, repetitions: 7),
                Metronome(tone: ArrayCadences.tones[9], selectedToneIndex:9, tempo: 300.0, repetitions: 1),
                Metronome(tone: ArrayCadences.tones[0], selectedToneIndex:0, tempo: 300.0, repetitions: 6),

            ])
        ]
    }
}



