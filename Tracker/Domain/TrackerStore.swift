//
//  TrackerStore.swift
//  Tracker
//
//  Created by admin on 24.01.2024.
//

import UIKit
import CoreData

final class TrackerStore {
    private let context: NSManagedObjectContext
    
    // MARK: - Initialisation
    
    convenience init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Methods
    
    func addNewTracker(from tracker: Tracker) throws -> TrackerCoreData? {
        guard let trackerCoreData = NSEntityDescription.entity(forEntityName: "TrackerCoreData", in: context) else {
            throw StoreError.failedToWrite
        }
        let newTracker = TrackerCoreData(entity: trackerCoreData, insertInto: context)
        newTracker.id = tracker.id
        newTracker.name = tracker.name
        newTracker.color = UIColorMarshalling.hexString(from: tracker.color)
        newTracker.emoji = tracker.emoji
        newTracker.dateEvents = tracker.dateEvents as NSArray?
        newTracker.isPinned = tracker.isPinned
        return newTracker
    }
    
    func fetchTrackers() throws -> [Tracker] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw StoreError.failedReading
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        
        do {
            let trackerCoreDataArray = try managedContext.fetch(fetchRequest)
            let trackers = trackerCoreDataArray.map { trackerCoreData in
                return Tracker(
                    id: trackerCoreData.id ?? UUID(),
                    name: trackerCoreData.name ?? "",
                    color: UIColorMarshalling.color(from: trackerCoreData.color ?? ""),
                    emoji: trackerCoreData.emoji ?? "",
                    dateEvents: trackerCoreData.dateEvents as? [Int],
                    isPinned: trackerCoreData.isPinned
                )
            }
            return trackers
        } catch {
            throw StoreError.failedReading
        }
    }
    
    func decodingTrackers(from trackersCoreData: TrackerCoreData) throws -> Tracker {
        guard let id = trackersCoreData.id,
              let name = trackersCoreData.name,
              let color = trackersCoreData.color,
              let emoji = trackersCoreData.emoji
        else {
            throw StoreError.failedDecoding
        }
        return Tracker(
            id: id,
            name: name,
            color: UIColorMarshalling.color(from: color),
            emoji: emoji,
            dateEvents: trackersCoreData.dateEvents as? [Int],
            isPinned: trackersCoreData.isPinned
        )
    }
    
    func deleteTrackers(tracker: Tracker) throws {
        let fetchRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %@", tracker.id as CVarArg)
        do {
            let tracker = try context.fetch(fetchRequest)
            
            if let trackerToDelete = tracker.first {
                context.delete(trackerToDelete)
                try context.save()
            } else {
                throw StoreError.failedGettingTitle
            }
        } catch {
            throw StoreError.failedActoionDelete
        }
    }
    
    func updateTracker(with tracker: Tracker) throws {
        let fetchRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %@", tracker.id as CVarArg)
        do {
            let existingTrackers = try context.fetch(fetchRequest)
            
            if let existingTracker = existingTrackers.first {
                existingTracker.name = tracker.name
                existingTracker.color = UIColorMarshalling.hexString(from: tracker.color)
                existingTracker.emoji = tracker.emoji
                existingTracker.dateEvents = tracker.dateEvents as NSArray?
                existingTracker.isPinned = tracker.isPinned
                try context.save()
            } else {
                throw StoreError.trackerNotFound
            }
        } catch {
            throw StoreError.failedActoionUpdate
        }
    }
}
