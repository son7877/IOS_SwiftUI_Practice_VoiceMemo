//
//  OnboardingViewModel.swift
//  voiceMemo
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var onboardingContents: [OnboardingContent]
    
    init(
        onboardingContents: [OnboardingContent] = [
            .init(
            imageFileName: "onboarding_1",
            title: "설명1",
            subtitle: "Todo1"),
            
            .init(
            imageFileName: "onboarding_2",
            title: "설명2",
            subtitle: "Todo2"),
            
            .init(
            imageFileName: "onboarding_3",
            title: "설명3",
            subtitle: "Todo3"),
            
            .init(
            imageFileName: "onboarding_4",
            title: "설명4",
            subtitle: "Todo4"),
        ]
    ) {
        self.onboardingContents = onboardingContents
    }
    
}
