//
//  TimeEditor.swift
//  LoopKitUI
//
//  Created by Jonas Björkert on 2024-02-17.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKit

struct TimeEditor: View {
    var title: Text
    var description: Text
    @Binding var value: TimeInterval // Expected to be in seconds
    @Environment(\.appName) private var appName

    var savingMechanism: SavingMechanism<TimeInterval>
    var mode: SettingsPresentationMode
    
    @State private var isEditing: Bool = false
    @State private var presentedAlert: AlertContent?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ConfigurationPage(
            title: title,
            actionButtonTitle: Text(mode.buttonText()),
            actionButtonState: .enabled,
            cards: {
                Card {
                    SettingDescription(text: description, informationalContent: {text})
                    ExpandableSetting(
                        isEditing: $isEditing,
                        valueContent: {
                            Text("\(Int(value / 60)) minutes")
                        },
                        expandedContent: {
                            TimePicker(value: $value)
                        }
                    )
                }
            },
            actionAreaContent: {
                // Include any instructional text or additional content here
            },
            action: {
                saveValue()
            }
        )
    }
    
    private var text: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(TherapySetting.carbRatio.descriptiveText(appName: appName))
            Text(LocalizedString("You can add different carb ratios for different times of day by using the ➕.", comment: "Description of how to add a ratio"))
        }
        .accentColor(.secondary)
    }
    
    private func saveValue() {
        switch savingMechanism {
        case .synchronous(let save):
            save(value)
            dismiss()
        case .asynchronous(let save):
            save(value) { error in
                if let error = error {
                    presentedAlert = AlertContent(
                        title: Text("Error Saving Time"),
                        message: Text(error.localizedDescription)
                    )
                } else {
                    dismiss()
                }
            }
        }
    }
}
