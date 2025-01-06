//
//  SettingView.swift
//  voiceMemo
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        Text("Setting")
    }
}

// MARK: - TitleView
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(Color.customBlack)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
}

// MARK: - TotalTabCountView
private struct TotalTabCountView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        HStack {
            TabCountView(title: "To do", count: homeViewModel.todosCount)
            
            Spacer()
                .frame(width: 70)
            
            TabCountView(title: "Memo", count: homeViewModel.memoCount)
            
            Spacer()
                .frame(width: 70)
            
            TabCountView(title: "Voice Recorder", count: homeViewModel.voiceRecordersCount)
        }
    }
}

// MARK: - TabCountView
private struct TabCountView: View {
  private var title: String
  private var count: Int
  
  fileprivate init(
    title: String,
    count: Int
  ) {
    self.title = title
    self.count = count
  }
  
  fileprivate var body: some View {
    VStack(spacing: 5) {
      Text(title)
        .font(.system(size: 14))
        .foregroundColor(.customBlack)
      
      Text("\(count)")
        .font(.system(size: 30, weight: .medium))
        .foregroundColor(.customBlack)
    }
  }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
