//
//  Events.swift
//  Tracker
//
//  Created by admin on 31.01.2024.
//

import Foundation

enum Events: String, CaseIterable {
    case open = "open"
    case close = "close"
    case click = "click"
}

enum Items: String, CaseIterable {
    case addTracker = "addTracker"
    case cancelCreation = "cancelCreation"
    case updateTracker = "updateTracker"
    case filterByDate = "filterByDate"
    case filter = "filter"
    case pinned = "pinned"
    case unpinned = "unpinned"
    case trackerCompleted = "trackerCompleted"
    case trackerNotCompleted = "trackerNotCompleted"
    case edit = "edit"
    case delete = "delete"
}
