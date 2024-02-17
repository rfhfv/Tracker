//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by admin on 24.01.2024.
//

import UIKit
import CoreData

protocol TrackerCategoryStoreDelegate: AnyObject {
    func didUpdateData(in store: TrackerCategoryStore)
}

// MARK: - TrackerCategoryStore

final class TrackerCategoryStore: NSObject {
    weak var delegate: TrackerCategoryStoreDelegate?
    private let context: NSManagedObjectContext
    private let trackerStore = TrackerStore()
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerCategoryCoreData>! = {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        let sortDescriptor = NSSortDescriptor(keyPath: \TrackerCategoryCoreData.titleCategory, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        try? controller.performFetch()
        return controller
    }()
    
    // MARK: - Initialisation
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

// MARK: - Category management

extension TrackerCategoryStore {
    // MARK: - Methods
    
    func createCategory(_ category: TrackerCategory) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "TrackerCategoryCoreData", in: context) else {
            throw StoreError.failedToWrite
        }
        let categoryEntity = TrackerCategoryCoreData(entity: entity, insertInto: context)
        categoryEntity.titleCategory = category.title
        categoryEntity.trackers = NSSet(array: [])
        try context.save()
    }
    
    func fetchAllCategories() throws -> [TrackerCategoryCoreData] {
        return try context.fetch(NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData"))
    }
    
    func deleteCategory(with title: String) throws {
        let request = fetchedResultController.fetchRequest
        request.predicate = NSPredicate(format: "%K == %@", "titleCategory", title)
        do {
            let categories = try context.fetch(request)
            if let categoryToDelete = categories.first {
                context.delete(categoryToDelete)
                try context.save()
            } else {
                throw StoreError.failedGettingTitle
            }
        } catch {
            throw StoreError.failedActoionDelete
        }
    }
}

// MARK: - Creating trackers in categories

extension TrackerCategoryStore {
    // MARK: - Methods
    
    func createCategoryAndTracker(tracker: Tracker, with titleCategory: String) throws {
        guard let trackerCoreData = try trackerStore.addNewTracker(from: tracker) else {
            throw StoreError.failedToWrite
        }
        guard let existingCategory = try fetchCategory(with: titleCategory) else {
            throw StoreError.failedReading
        }
        var existingTrackers = existingCategory.trackers?.allObjects as? [TrackerCoreData] ?? []
        existingTrackers.append(trackerCoreData)
        existingCategory.trackers = NSSet(array: existingTrackers)
        try context.save()
    }
    
    func decodingCategory(from trackerCategoryCoreData: TrackerCategoryCoreData) throws -> TrackerCategory {
        guard let title = trackerCategoryCoreData.titleCategory else {
            throw StoreError.failedReading
        }
        guard let trackers = trackerCategoryCoreData.trackers else {
            throw StoreError.failedReading
        }
        return TrackerCategory(title: title, trackers: trackers.compactMap { coreDataTracker -> Tracker? in
            if let coreDataTracker = coreDataTracker as? TrackerCoreData {
                return try? trackerStore.decodingTrackers(from: coreDataTracker)
            }
            return nil
        })
    }
    
    // MARK: - Private methods
    
    private func fetchCategory(with title: String) throws -> TrackerCategoryCoreData? {
        let request = fetchedResultController.fetchRequest
        request.predicate = NSPredicate(format: "titleCategory == %@", title)
        return try context.fetch(request).first
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateData(in: self)
    }
}
