//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by admin on 04.02.2024.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    func testTabBarController() {
        let viewController = TabBarController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testTrackersViewController() {
        let viewController = TrackersViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testStatisticsViewController() {
        let viewController = StatisticsViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))

    }
    
    func testFilterViewController() {
        let viewController = FilterViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testCreatingNewTrackerViewController() {
        let viewController = CreatingNewTrackerViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testCreatingHabitViewController() {
        let viewController = CreatingHabitViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testCreatingIrregularEventViewController() {
        let viewController = CreatingIrregularEventViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testCategoryViewController() {
        let viewController = CategoryViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testCreatingCategoryViewController() {
        let viewController = CreatingCategoryViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
    
    func testScheduleViewController() {
        let viewController = ScheduleViewController()
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .dark)))
        assertSnapshot(of: viewController, as: .image(traits: UITraitCollection(userInterfaceStyle: .light)))
    }
}
