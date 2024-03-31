//
//  PreferencesSetting.swift
//  LoopKit
//
//  Created by Jonas Björkert on 2024-02-17.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import Foundation

public enum PreferencesSetting {
    case maxCarbEntryFutureTime
}

extension PreferencesSetting: Equatable { }

public extension PreferencesSetting {
    var title: String {
        switch self {
        case .maxCarbEntryFutureTime:
            return LocalizedString("Max Carb Entry Future Time", comment: "Title text for max carb entry future time setting")
        }
    }
    
    var smallTitle: String {
        return title
    }
    
    func descriptiveText(appName: String) -> String {
        switch self {
        case .maxCarbEntryFutureTime:
            return String(format: LocalizedString("Max Carb Entry Future Time limits how far in the future you can enter carb data in %1$@, helping to avoid mistakes.", comment: "Descriptive text for max carb entry future time (1: app name)"), appName)
        }
    }
}

// MARK: Guardrails
public extension PreferencesSetting {
    var guardrailCaptionForLowValue: String {
        switch self {
        case .maxCarbEntryFutureTime:
            return LocalizedString("The value you have entered is lower than what is typically recommended, which may restrict your ability to plan meals in advance.", comment: "Descriptive text for guardrail low value warning for max carb entry future time")
        }
    }
    
    var guardrailCaptionForHighValue: String {
        switch self {
        case .maxCarbEntryFutureTime:
            return LocalizedString("The value you have entered is higher than what is typically recommended, which may lead to unrealistic carb entries.", comment: "Descriptive text for guardrail high value warning for max carb entry future time")
        }
    }
    
    var guardrailCaptionForOutsideValues: String {
        return LocalizedString("The value you have entered for Max Carb Entry Future Time is outside of the recommended range, which may impact the app's performance.", comment: "Descriptive text for guardrail outside value warning for max carb entry future time")
    }
    
    var guardrailSaveWarningCaption: String {
        return LocalizedString("Saving this value for Max Carb Entry Future Time might lead to unexpected behavior or limitations in the app.", comment: "Descriptive text for saving settings outside the recommended range for max carb entry future time")
    }
}
