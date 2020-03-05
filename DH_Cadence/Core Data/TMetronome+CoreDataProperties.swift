//
//  TMetronome+CoreDataProperties.swift
//  DH_Cadence
//
//  Created by David Hou on 3/5/20.
//  Copyright © 2020 David Hou. All rights reserved.
//
//

import Foundation
import CoreData


extension TMetronome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TMetronome> {
        return NSFetchRequest<TMetronome>(entityName: "TMetronome")
    }

    @NSManaged public var tone: String?
    @NSManaged public var selectedToneIndex: Int64
    @NSManaged public var tempo: Int64
    @NSManaged public var repetitions: Int64

}
