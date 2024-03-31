//
//  PreferencesView.swift
//  LoopKitUI
//
//  Created by Jonas Björkert on 2024-01-27.
//  Copyright © 2024 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKit

public struct PreferencesView: View {
    @Environment(\.dismissAction) private var dismiss
    @Environment(\.appName) private var appName

    @ObservedObject var viewModel: PreferencesViewModel
    
    public init(viewModel: PreferencesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        navigationViewWrappedContent
    }
}

extension PreferencesView {
    private var navigationViewWrappedContent: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                content
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            dismissButton
                        }
                    }
                    .navigationBarTitle(preferencesTitle, displayMode: .large)
            }
        }
    }

    private var dismissButton: some View {
        Button(action: dismiss) {
            Text("Done")
        }
    }
    
    private var preferencesTitle: String {
        return "Preferences"
    }

    private var content: some View {
        CardList(title: nil, style: .sectioned(cardListSections)) //, trailer: cardListTrailer
    }

    private var cardListSections: [CardListSection] {
        var cardListSections: [CardListSection] = []
        
        cardListSections.append(preferencesCardListSection)
        
        return cardListSections
    }
    
    private var preferencesCardListSection: CardListSection {
        CardListSection {
            preferencesCardStack
                .spacing(20)
        }
    }
    
    private var preferencesCardStack: CardStack {
        var cards: [Card] = []
        
        cards.append(maxCarbEntryFutureTimeSection)
        
        return CardStack(cards: cards)
    }
    
    @ViewBuilder
    func screen(for setting: PreferencesSetting, dismiss: @escaping () -> Void) -> some View {
        switch setting {
            case .maxCarbEntryFutureTime:
            MaxCarbEntryFutureTimeEditor(preferencesViewModel: viewModel, didSave: dismiss)
        }
    }

    private func card<Content>(for preferencesSetting: PreferencesSetting, @ViewBuilder content: @escaping () -> Content) -> Card where Content: View {
        Card {
            SectionWithTapToEdit(
                isEnabled: true,
                title: preferencesSetting.title,
                descriptiveText: preferencesSetting.descriptiveText(appName: appName),
                destination: { dismiss in
                    screen(for: preferencesSetting, dismiss: dismiss)
                        .environment(\.dismissAction, dismiss)
                },
                content: content
            )
        }
    }

    private var maxCarbEntryFutureTimeSection: Card {
        card(for: .maxCarbEntryFutureTime) {
            SectionDivider()
            HStack {
                Spacer()
                GuardrailConstrainedTimeIntervalView(
                 value: self.viewModel.maxCarbEntryFutureTime,
                 guardrail: .maxCarbEntryFutureTimeThreshold,
                 isEditing: false,
                 // Workaround for strange animation behavior on appearance
                 forceDisableAnimations: true
                 )
            }
        }
    }
}

fileprivate struct SectionDivider: View {
    var body: some View {
        Divider()
            .padding(.trailing, -16)
    }
}
