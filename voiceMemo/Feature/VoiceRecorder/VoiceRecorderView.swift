//
//  VoiceRecorderView.swift
//  voiceMemo
//

import SwiftUI

struct VoiceRecorderView: View {
    @StateObject private var voiceRecorderViewModel = VoiceRecorderViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                TitleView()
                
                if voiceRecorderViewModel.recordedFiles.isEmpty {
                    AnnounementView()
                } else {
                    VoiceRecorderListView(voiceRecorderViewModel: voiceRecorderViewModel)
                        .padding(.top, 15)
                }
                
                Spacer()
            }
            
            RecordBtnView(voiceRecorderViewModel: voiceRecorderViewModel)
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
        }
        .alert(
            "선택한 음성 메모를 삭제하시겠습니까?",
            isPresented: $voiceRecorderViewModel.isDisplayRemoveVoiceRecorederAlert
        ) {
            Button("삭제", role: .destructive) {
                voiceRecorderViewModel.removeSelectedVoiceRecord()
            }
            Button("취소", role: .cancel) {}
        }
        .alert(
            voiceRecorderViewModel.alertMessage,
            isPresented: $voiceRecorderViewModel.isDisplayAlert
        ) {
            Button("확인", role: .cancel) {}
        }
//        .onChange(
//            of: voiceRecorderViewModel.recordedFiles,
//            perform: { recordedFiles in
//                
//            }
//        )
    }
}

// MARK: - TitleView
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("음성 메모")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(Color.customBlack)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}

// MARK: - AnnounementView
private struct AnnounementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Rectangle()
                .fill(Color.customCoolGray)
                .frame(height: 1)
            
            Spacer()
                .frame(height: 180)
            
            Image("pencil")
                .renderingMode(.template)
            Text("음성 메모를 남겨보세요.")
            Text("녹음 버튼을 눌러 시작하세요.")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundStyle(Color.customGray2)
    }
}

// MARK: - VoiceRecorderListView
private struct VoiceRecorderListView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    
    fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
    }
    
    fileprivate var body: some View {
        ScrollView(.vertical) {
            VStack {
                Rectangle()
                    .fill(Color.customGray2)
                    .frame(height: 1)
                
                ForEach(voiceRecorderViewModel.recordedFiles, id: \.self) {recordedFile in
                    VoiceRecorderCellView(
                        voiceRecorderViewModel: voiceRecorderViewModel,
                        recordedFile: recordedFile
                    )
                }
            }
        }
    }
}

// MARK: - VoiceRecorderCellView
private struct VoiceRecorderCellView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    private var recordedFile: URL
    private var creationDate: Date?
    private var duration: TimeInterval?
    private var progressBarValue: Float {
        if voiceRecorderViewModel.selectedRecordedFile == recordedFile
            && (voiceRecorderViewModel.isPlaying || voiceRecorderViewModel.isPaused) {
            return Float(voiceRecorderViewModel.playedTime) / Float(duration ?? 1)
        } else {
            return 0
        }
    }
    
    fileprivate init(
        voiceRecorderViewModel: VoiceRecorderViewModel,
        recordedFile: URL
    ) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
        self.recordedFile = recordedFile
        (creationDate, duration) = voiceRecorderViewModel.getFileInfo(for: recordedFile)
    }
    
    fileprivate var body: some View {
        VStack {
            Button(
                action: {
                    voiceRecorderViewModel.voiceRecordCellTapped(recordedFile)
                },
                label: {
                    VStack {
                        HStack {
                            Text(recordedFile.lastPathComponent)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(Color.customBlack)
                            
                            Spacer()
                        }
                        
                        Spacer()
                            .frame(height: 5)
                        
                        HStack {
                            if let creationDate = creationDate {
                                Text(creationDate.formmattedVoiceRecorderTime)
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.customGray1)
                            }
                            
                            Spacer()
                            
                            if voiceRecorderViewModel.selectedRecordedFile != recordedFile,
                                let duration = duration {
                                Text(duration.formattedTimeInterval)
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.customIconGray)
                            }
                        }
                    }
                }
            )
            .padding(.horizontal, 20)
            
            if voiceRecorderViewModel.selectedRecordedFile == recordedFile {
                VStack {
                    ProgressBar(progress: progressBarValue)
                        .frame(height: 2)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack {
                        Text(voiceRecorderViewModel.playedTime.formattedTimeInterval)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(Color.customIconGray)
                        
                        Spacer()
                        
                        if let duration = duration {
                            Text(duration.formattedTimeInterval)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(Color.customIconGray)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    HStack {
                        Spacer()
                        
                        Button(
                            action: {
                                if voiceRecorderViewModel.isPaused {
                                    voiceRecorderViewModel.resumePlaying()
                                } else {
                                    voiceRecorderViewModel.startPlaying(recordingURL: recordedFile)
                                }
                            },
                            label: {
                                Image("play")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.customBlack)
                            }
                        )
                        
                        Spacer()
                            .frame(width: 10)
                        
                        Button(
                            action: {
                                if voiceRecorderViewModel.isPlaying {
                                    voiceRecorderViewModel.pausePlaying()
                                }
                            },
                            label: {
                                Image("pause")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.customBlack)
                            }
                        )
                        
                        Spacer()
                        
                        Button(
                            action: {
                                voiceRecorderViewModel.removeBtnTapped()
                            },
                            label: {
                                Image("trash")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(Color.customBlack)
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
        }
    }
}

// MARK: - ProgressBar
private struct ProgressBar: View {
    private var progress: Float
    
    fileprivate init(progress: Float) {
        self.progress = progress
    }
    
    fileprivate var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.customGray2)
                
                Rectangle()
                    .fill(Color.customBlack)
                    .frame(width: CGFloat(self.progress) * geometry.size.width)
            }
        }
    }
}

// MARK: - RecordBtnView
private struct RecordBtnView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    @State private var isAnimation: Bool
    
    fileprivate init(
        voiceRecorderViewModel: VoiceRecorderViewModel,
        isAnimation: Bool = false
    ) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
        self.isAnimation = isAnimation
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button(
                    action: {
                        voiceRecorderViewModel.recordBtnTapped()
                    },
                    label: {
                        if voiceRecorderViewModel.isRecording {
                            Image("mic_recording")
                                .scaleEffect(isAnimation ? 1.5 : 1.0)
                                .onAppear {
                                    withAnimation(.spring().repeatForever()){
                                        isAnimation.toggle()
                                    }
                                }
                                .onDisappear {
                                    isAnimation = false
                                }
                        } else {
                            Image("mic")
                        }
                    }
                )
            }
        }
    }
}

struct VoiceRecorderView_Previews: PreviewProvider {
  static var previews: some View {
    VoiceRecorderView()
  }
}
