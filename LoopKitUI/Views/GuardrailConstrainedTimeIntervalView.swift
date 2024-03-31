//
//  GuardrailConstrainedTimeIntervalView.swift
//  LoopKitUI
//
//  Created by Jonas Björkert on 2024-02-25.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import SwiftUI
import HealthKit
import LoopKit


public struct GuardrailConstrainedTimeIntervalView: View {
    @Environment(\.guidanceColors) var guidanceColors
    var value: TimeInterval?
    var guardrail: Guardrail<TimeInterval>
    var isEditing: Bool
    var isSupportedValue: Bool
    var formatter: DateComponentsFormatter
    var iconSpacing: CGFloat
    var isUnitLabelVisible: Bool
    var forceDisableAnimations: Bool
    
    @State private var hasAppeared = false
    
    public init(
        value: TimeInterval,
        guardrail: Guardrail<TimeInterval>,
        isEditing: Bool,
        isSupportedValue: Bool = true,
        iconSpacing: CGFloat = 8,
        isUnitLabelVisible: Bool = true,
        forceDisableAnimations: Bool = false
    ) {
        self.value = value
        self.guardrail = guardrail
        self.isEditing = isEditing
        self.isSupportedValue = isSupportedValue
        self.iconSpacing = iconSpacing
        self.isUnitLabelVisible = isUnitLabelVisible
        self.forceDisableAnimations = forceDisableAnimations
        
        
        self.formatter = {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute]
            formatter.unitsStyle = .short
            formatter.zeroFormattingBehavior = [.dropLeading, .dropTrailing]
            
            return formatter
        }()
    }
    
    public var body: some View {
        HStack {
            HStack(spacing: iconSpacing) {
                if value != nil {
                    if guardrail.classification(for: value!) != .withinRecommendedRange {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(warningColor)
                            .transition(.springInDisappear)
                    }
                    
                    Text(formatter.string(from: value!) ?? "")
                        .foregroundColor(warningColor)
                        .fixedSize(horizontal: true, vertical: false)
                } else {
                    Text("–")
                        .foregroundColor(.secondary)
                }
            }
            
/*            if isUnitLabelVisible {
                Text(unit.shortLocalizedUnitString())
                    .foregroundColor(Color(.secondaryLabel))
            }*/
        }
        .accessibilityElement(children: .combine)
        .onAppear { self.hasAppeared = true }
        .animation(animation)
    }
    
    private var animation: Animation? {
        // A conditional implicit animation seems to behave funky on first appearance.
        // Disable animations until the view has appeared.
        if forceDisableAnimations || !hasAppeared {
            return nil
        }
        
        // While editing, the text width is liable to change, which can cause a slow-feeling animation
        // of the guardrail warning icon. Disable animations while editing.
        return isEditing ? nil : .default
    }
    
    private var warningColor: Color {
        guard let value = value else {
            return .primary
        }
        
        guard isSupportedValue else { return guidanceColors.critical }
        
        switch guardrail.classification(for: value) {
        case .withinRecommendedRange:
            return isEditing ? .accentColor : guidanceColors.acceptable
        case .outsideRecommendedRange(let threshold):
            switch threshold {
            case .minimum, .maximum:
                return guidanceColors.critical
            case .belowRecommended, .aboveRecommended:
                return guidanceColors.warning
            }
        }
    }
}

fileprivate extension AnyTransition {
    static let springInDisappear = asymmetric(
        insertion: AnyTransition.scale.animation(.spring(dampingFraction: 0.5)),
        removal: .identity
    )
}