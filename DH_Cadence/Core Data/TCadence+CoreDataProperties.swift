//
//  TCadence+CoreDataProperties.swift
//  DH_Cadence
//
//  Created by David Hou on 3/5/20.
//  Copyright © 2020 David Hou. All rights reserved.
//
//

import Foundation
import CoreData


extension TCadence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TCadence> {
        return NSFetchRequest<TCadence>(entityName: "TCadence")
    }

    @NSManaged public var name: String?
    @NSManaged public var repetitions: Int64
    @NSManaged public var metronomes: NSOrderedSet?

}

// MARK: Generated accessors for metronomes
extension TCadence {

    @objc(insertObject:inMetronomesAtIndex:)
    @NSManaged public func insertIntoMetronomes(_ value: TMetronome, at idx: Int)

    @objc(removeObjectFromMetronomesAtIndex:)
    @NSManaged public func removeFromMetronomes(at idx: Int)

    @objc(insertMetronomes:atIndexes:)
    @NSManaged public func insertIntoMetronomes(_ values: [TMetronome], at indexes: NSIndexSet)

    @objc(removeMetronomesAtIndexes:)
    @NSManaged public func removeFromMetronomes(at indexes: NSIndexSet)

    @objc(replaceObjectInMetronomesAtIndex:withObject:)
    @NSManaged public func replaceMetronomes(at idx: Int, with value: TMetronome)

    @objc(replaceMetronomesAtIndexes:withMetronomes:)
    @NSManaged public func replaceMetronomes(at indexes: NSIndexSet, with values: [TMetronome])

    @objc(addMetronomesObject:)
    @NSManaged public func addToMetronomes(_ value: TMetronome)

    @objc(removeMetronomesObject:)
    @NSManaged public func removeFromMetronomes(_ value: TMetronome)

    @objc(addMetronomes:)
    @NSManaged public func addToMetronomes(_ values: NSOrderedSet)

    @objc(removeMetronomes:)
    @NSManaged public func removeFromMetronomes(_ values: NSOrderedSet)

}
