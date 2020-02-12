//
//  Cadence.swift
//  DH_Cadence
//
//  Created by David Hou on 2/10/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import Foundation

struct Metronome: Identifiable {
    let id = UUID()
    var tone: String
    var tempo: Int8
    var repetitions: Int8
}

struct Cadence: Identifiable {
    let id = UUID()
    var name: String
    var repetitions: Int
    var metronomes: [Metronome]
}


