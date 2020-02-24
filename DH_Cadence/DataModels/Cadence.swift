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

struct Metronome { //: Identifiable {
    //public var id = UUID()
    var tone: String
    var selectedToneIndex: Int
    var tempo: Int
    var repetitions: Int
}

struct Cadence{  //: Identifiable, Equatable {

    public var id = UUID()
    
    var name: String = ""
    var repetitions: Int = 0
    var metronomes: [Metronome] = []
    
}

class ArrayCadences: ObservableObject {
    
    @Published var cadences: [Cadence]
        
    init() {
        self.cadences = [
            Cadence(name: "Cadence 1", repetitions: 10, metronomes: [
                Metronome(tone: "Tone 1", selectedToneIndex:0, tempo: 60, repetitions: 4),
                Metronome(tone: "Tone 2", selectedToneIndex:0, tempo: 60, repetitions: 7),
                Metronome(tone: "Tone 3", selectedToneIndex:0, tempo: 60, repetitions: 8),
            ]),
            Cadence(name: "Cadence 2", repetitions: 20, metronomes: [])
        ]
    }
}



