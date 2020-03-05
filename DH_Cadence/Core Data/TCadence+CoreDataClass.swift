//
//  TCadence+CoreDataClass.swift
//  DH_Cadence
//
//  Created by David Hou on 3/4/20.
//  Copyright © 2020 David Hou. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TCadence)
public class TCadence: NSManagedObject {

    public var wrappedName: String {
        name ?? "Untitled"
    }
    public var wrappedRepetitions: Int64 {
        repetitions
    }
    public var wrappedMetronomes: [TMetronome] {
        metronomes?.array as? [TMetronome] ?? []
    }
}
