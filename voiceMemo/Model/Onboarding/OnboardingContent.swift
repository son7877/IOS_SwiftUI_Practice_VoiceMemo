//
//  OnboardingContent.swift
//  voiceMemo
//

import Foundation

struct OnboardingContent : Hashable { // 추후 탭 뷰에서 사용할 수 있도록 Hashable 프로토콜 채택
    var imageFileName: String
    var title: String
    var subtitle: String
    
    init(imageFileName: String, title: String, subtitle: String) {
        self.imageFileName = imageFileName
        self.title = title
        self.subtitle = subtitle
    }
}
