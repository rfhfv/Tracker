//
//  AnalyticsService.swift
//  Tracker
//
//  Created by admin on 31.01.2024.
//


import Foundation
import YandexMobileMetrica

struct AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "91a9ebe9-1d7f-4d71-a096-88711ee134d8") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(event: Events, params : [AnyHashable : Any]) {
        YMMYandexMetrica.reportEvent(event.rawValue, parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
