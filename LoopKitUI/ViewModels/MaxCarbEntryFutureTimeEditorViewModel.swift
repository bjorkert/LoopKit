//
//  MaxCarbEntryFutureTimeEditorViewModel.swift
//  LoopKitUI
//
//  Created by Jonas Björkert on 2024-02-17.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import Foundation
import HealthKit
import LoopKit

struct MaxCarbEntryFutureTimeEditorViewModel {
    let maxCarbEntryFutureTime: TimeInterval
    
    var saveMaxCarbEntryFutureTime: (_ newValue: TimeInterval) -> Void
    
    public init(preferencesViewModel: PreferencesViewModel, didSave: (() -> Void)? = nil) {
        self.maxCarbEntryFutureTime = preferencesViewModel.maxCarbEntryFutureTime
        
        self.saveMaxCarbEntryFutureTime = { [weak preferencesViewModel] newValue in
            preferencesViewModel?.updateMaxCarbEntryFutureTime(newValue)

            didSave?()
        }
    }
}
