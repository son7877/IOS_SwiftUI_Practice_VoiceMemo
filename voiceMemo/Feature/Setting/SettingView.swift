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

// MARK: - TotalTabMoveView
private struct TotalTabMoveView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray1)
                .frame(height: 1)
        
            TabMoveView(
                title: "To do List",
                tabAction: {
                    homeViewModel.changeSelectedTab(.todoList)
                }
            )
        
            TabMoveView(
                title: "메모장",
                tabAction: {
                    homeViewModel.changeSelectedTab(.memo)
                }
            )
        
            TabMoveView(
                title: "음성메모",
                tabAction: {
                    homeViewModel.changeSelectedTab(.voiceRecorder)
                }
            )
        
            TabMoveView(
                title: "타이머",
                tabAction: {
                    homeViewModel.changeSelectedTab(.timer)
                }
            )
        
            Rectangle()
                .fill(Color.customGray1)
                .frame(height: 1)
        }
    }
}

// MARK: - TabMoveView
private struct TabMoveView: View {
    private var title: String
    private var tabAction: () -> Void
  
    fileprivate init(
        title: String,
        tabAction: @escaping () -> Void
    ) {
        self.title = title
        self.tabAction = tabAction
    }
  
    fileprivate var body: some View {
        Button(action: tabAction) {
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.customBlack)
                
                Spacer()
                
                Image(systemName: "arrowRight")
            }
            .padding(.all, 20)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
