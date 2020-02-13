//
//  Cadence.swift
//  DH_Cadence
//
//  Created by David Hou on 2/10/20.
//  Copyright © 2020 David Hou. All rights reserved.
//

import Foundation

struct Metronome: Identifiable {
    public var id = UUID()
    var tone: String
    var tempo: Int8
    var repetitions: Int8
}

struct Cadence: Identifiable, Equatable{
    static func == (lhs: Cadence, rhs: Cadence) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id = UUID()
    var name: String
    var repetitions: Int
    var metronomes: [Metronome]
}


