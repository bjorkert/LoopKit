//
//  Guardrail+Preferences.swift
//  LoopKit
//
//  Created by Jonas Björkert on 2024-02-25.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import Foundation

public extension Guardrail where Value == TimeInterval {
    static let maxCarbEntryFutureTimeThreshold = Guardrail(
        absoluteBounds: 0...TimeInterval(hours: 20),
        recommendedBounds: TimeInterval(minutes: 30)...TimeInterval(hours: 8),
        startingSuggestion: TimeInterval(hours: 1)
    )
}
