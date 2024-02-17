//
//  StatisticsViewModel.swift
//  Tracker
//
//  Created by admin on 31.01.2024.
//

import Foundation

// MARK: - Protocol

protocol StatisticViewControllerProtocol: AnyObject {
    var completedTrackers: [TrackerRecord] { get set }
}

// MARK: - UIViewController

final class StatisticsViewModel: StatisticViewControllerProtocol {
    @ObservableValue var completedTrackers: [TrackerRecord] = [] {
        didSet {
            getStatisticsCalculation()
        }
    }
    var statistics: [StatisticsModel] = []
    private let trackerRecordStore = TrackerRecordStore()
}

// MARK: - CoreData

extension StatisticsViewModel {
    func fetchStatistics() throws {
        do {
            completedTrackers = try trackerRecordStore.fetchRecords()
            getStatisticsCalculation()
        } catch {
            throw StoreError.failedReading
        }
    }
}

// MARK: - LogicStatistics

extension StatisticsViewModel {
    private func getStatisticsCalculation() {
        if completedTrackers.isEmpty {
            statistics.removeAll()
        } else {
            statistics = [
                .init(title: "Лучший период", value: "\(bestPeriod())"),
                .init(title: "Идеальные дни", value: "\(idealDays())"),
                .init(title: "Трекеров завершено", value: "\(trackersCompleted())"),
                .init(title: "Среднее значение", value: "\(averageValue())")
            ]
        }
    }
    
    private func bestPeriod() -> Int {
        let countDict = Dictionary(grouping: completedTrackers, by: { $0.id }).mapValues { $0.count }
        guard let maxCount = countDict.values.max() else {
            return 0
        }
        return maxCount
    }
    
    private func idealDays() -> Int {
        return 0
    }
    
    private func trackersCompleted() -> Int {
        return completedTrackers.count
    }
    
    private func averageValue() -> Int {
        return 0
    }
}

// MARK: - TrackerCategoryStoreDelegate

extension StatisticsViewModel: TrackerRecordStoreDelegate {
    func didUpdateData(in store: TrackerRecordStore) {
        try? fetchStatistics()
    }
}
