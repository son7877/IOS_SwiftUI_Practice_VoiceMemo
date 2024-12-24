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

// MARK: - TimerPickerView
private struct TimerPickerView: View {
    @ObservedObject private var timeViewModel: TimerViewModel
    
    fileprivate init(timeViewModel: TimerViewModel) {
        self.timeViewModel = timeViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
            
            HStack {
                Picker("Hour", selection: $timeViewModel.time.hours) {
                    ForEach(0..<24) {
                        Text("\($0):")
                    }
                }
                
                Picker("Minute", selection: $timeViewModel.time.minutes) {
                    ForEach(0..<60) {
                        Text("\($0):")
                    }
                }
                
                Picker("Second", selection: $timeViewModel.time.seconds) {
                    ForEach(0..<60) {
                        Text("\($0)")
                    }
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
