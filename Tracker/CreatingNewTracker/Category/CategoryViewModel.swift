//
//  CategoryViewModel.swift
//  Tracker
//
//

import Foundation

// MARK: - CategoryViewModel

final class CategoryViewModel {
    @ObservableValue private(set) var categories: [TrackerCategory] = []
    
    weak var delegateHabbit: CreatingHabitViewControllerDelegate?
    weak var delegateIrregular: CreatingIrregularEventViewControllerDelegate?
    private let dataSorege = DataStorege.shared
    private let trackerCategoryStore = TrackerCategoryStore()
    
    func categoriesCount() -> Int {
        return categories.count
    }
    
    func addingCategoryToCreate(_ indexPath: IndexPath){
        let nameCategory = categories[indexPath.row].title
        delegateIrregular?.updateSubitle(nameSubitle: nameCategory)
        delegateHabbit?.updateSubitle(nameSubitle: nameCategory)
    }
    
    func selectedCategoryForCheckmark(_ indexPath: IndexPath) {
        dataSorege.saveIndexPathForCheckmark(indexPath)
    }
    
    func loadIndexPathForCheckmark() -> IndexPath? {
        return dataSorege.loadIndexPathForCheckmark()
    }
}

// MARK: - CategoryStoreCoreDate

extension CategoryViewModel {
    func fetchCategory() throws {
        do {
            let coreDataCategories = try trackerCategoryStore.fetchAllCategories()
            categories = try coreDataCategories.compactMap { coreDataCategory in
                return try trackerCategoryStore.decodingCategory(from: coreDataCategory)
            }
        } catch {
            throw StoreError.failedReading
        }
    }
    
    func createCategory(nameOfCategory: String) throws {
        do {
            let newCategory = TrackerCategory(title: nameOfCategory, trackers: [])
            try trackerCategoryStore.createCategory(newCategory)
        } catch {
            throw StoreError.failedToWrite
        }
    }
    
    func removeCategory(atIndex index: Int) throws {
        let nameOfCategory = categories[index].title
        do {
            try trackerCategoryStore.deleteCategory(with: nameOfCategory)
            try fetchCategory()
        } catch {
            throw StoreError.failedActoionDelete
        }
    }
}

// MARK: - TrackerStoreDelegate

extension CategoryViewModel: TrackerCategoryStoreDelegate {
    func didUpdateData(in store: TrackerCategoryStore) {
        try? fetchCategory()
    }
}
