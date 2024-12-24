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

// MARK: - TimerCreateBtnView
private struct TimerCreateBtnView: View {
    @ObservedObject private var timeViewModel: TimerViewModel
    
    fileprivate init(timeViewModel: TimerViewModel) {
        self.timeViewModel = timeViewModel
    }
    
    fileprivate var body: some View {
        Button {
            timeViewModel.settingBtnTapped()
        } label: {
            Text("설정")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.customGreen)
        }
    }
}

// MARK: - TimerOperationView
private struct TimerOperationView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text("\(timerViewModel.timeRemaining.formattedTimeString)")
                        .font(.system(size: 28))
                        .foregroundStyle(Color.customBlack)
                        .monospaced() // 고정폭 글꼴로 표시
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: "bell.fill")
                        
                        Text("\(timerViewModel.time.convertedSeconds.formattedTimeString)")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.customBlack)
                            .padding(.top, 10)
                    }
                }
                
                Circle()
                    .stroke(Color.customGreen, lineWidth: 6)
                    .frame(width: 350)
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                Button(
                    action: {
                        timerViewModel.cancelBtnTapped()
                    },
                    label: {
                        Text("취소")
                            .font(.system(size: 16))
                            .foregroundStyle(Color.customBlack)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 25)
                            .background(
                                Circle()
                                    .fill(Color.customGray2.opacity(0.2))
                            )
                    }
                )
                
                Spacer()
                
                Button(
                    action: {
                        timerViewModel.pauseOrResumeBtnTapped()
                    },
                    label: {
                        Image(systemName: timerViewModel.isPaused ? "play.fill" : "pause.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.customBlack)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 25)
                            .background(
                                Circle()
                                    .fill(Color.customGray2.opacity(0.2))
                            )
                    }
                )
            }
            .padding(.horizontal, 20)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
