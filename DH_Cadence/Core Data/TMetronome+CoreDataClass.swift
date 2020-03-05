//
//  TMetronome+CoreDataClass.swift
//  DH_Cadence
//
//  Created by David Hou on 3/4/20.
//  Copyright © 2020 David Hou. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TMetronome)
public class TMetronome: NSManagedObject {
    
    public var wrappedTone: String {
        tone ?? "Untitled"
    }

}
