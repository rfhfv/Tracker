//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by admin on 01.02.2024.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    func testTabBarController() {
        let viewController = TabBarController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testTrackersViewController() {
        let viewController = TrackersViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testStatisticsViewController() {
        let viewController = StatisticsViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testFilterViewController() {
        let viewController = FilterViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testCreatingNewTrackerViewController() {
        let viewController = CreatingNewTrackerViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testCreatingHabitViewController() {
        let viewController = CreatingHabitViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testCreatingIrregularEventViewController() {
        let viewController = CreatingIrregularEventViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testCategoryViewController() {
        let viewController = CategoryViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testCreatingCategoryViewController() {
        let viewController = CreatingCategoryViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testScheduleViewController() {
        let viewController = ScheduleViewController()
        assertSnapshot(matching: viewController, as: .image)
    }
}
