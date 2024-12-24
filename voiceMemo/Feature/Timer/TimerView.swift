//
//  TimerView.swift
//  voiceMemo
//

import SwiftUI

struct TimerView: View {
    @StateObject var timeViewModel = TimerViewModel()
    
    var body: some View {
        Text("Timer")
    }
}

// MARK: - SetTimerView
private struct SetTimerView: View {
    @ObservedObject private var timeViewModel: TimerViewModel
    
    fileprivate init(timeViewModel: TimerViewModel) {
        self.timeViewModel = timeViewModel
    }
    
    fileprivate var body: some View {
        Text("SetTimerView")
    }
}

// MARK: - TitleView
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("타이머")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(Color.customBlack)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
