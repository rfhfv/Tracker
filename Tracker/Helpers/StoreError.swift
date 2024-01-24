//
//  StoreError.swift
//  Tracker
//
//  Created by admin on 24.01.2024.
//

import Foundation

enum StoreError: Error {
    case failedToWrite
    case failedReading
    case failedDecoding
    case failedGettingTitle
    case failedActoionDelete
}
