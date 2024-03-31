//
//  PreferencesProvider.swift
//  LoopKit
//
//  Created by Jonas Björkert on 2024-02-17.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import Foundation

public protocol PreferencesProvider {
    var maxCarbEntryFutureTime: TimeInterval { get set }
}
