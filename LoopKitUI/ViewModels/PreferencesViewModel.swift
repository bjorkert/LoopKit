//
//  PreferencesViewModel.swift
//  LoopKitUI
//
//  Created by Jonas Björkert on 2024-02-17.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import Foundation
import LoopKit

public class PreferencesViewModel: ObservableObject {
    @Published var maxCarbEntryFutureTime: TimeInterval
    
    private var preferencesProvider: PreferencesProvider
    
    public init(preferencesProvider: PreferencesProvider) {
        self.preferencesProvider = preferencesProvider
        self.maxCarbEntryFutureTime = preferencesProvider.maxCarbEntryFutureTime
    }
    
    func updateMaxCarbEntryFutureTime(_ newValue: TimeInterval) {
        preferencesProvider.maxCarbEntryFutureTime = newValue
        self.maxCarbEntryFutureTime = newValue // Update the published property if needed
    }
}
