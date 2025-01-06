//
//  HomeViewModel.swift
//  voiceMemo
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    @Published var todosCount: Int
    @Published var memoCount: Int
    @Published var voiceRecordersCount: Int
    
    init(
        selectedTab: Tab = .voiceRecorder,
        todosCount: Int = 0,
        memoCount: Int = 0,
        voiceRecordersCount: Int = 0
    ) {
        self.selectedTab = selectedTab
        self.todosCount = todosCount
        self.memoCount = memoCount
        self.voiceRecordersCount = voiceRecordersCount
    }
}

extension HomeViewModel {
    func setTodosCount(_ count: Int) {
        todosCount = count
    }
    
    func setMemoCount(_ count: Int) {
        memoCount = count
    }
    
    func setVoiceRecordersCount(_ count: Int) {
        voiceRecordersCount = count
    }
    
    func changeSelectedTab(_ tab: Tab) {
        selectedTab = tab
    }
}
