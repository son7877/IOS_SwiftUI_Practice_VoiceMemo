//
//  VoiceRecorderViewModel.swift
//  voiceMemo
//

import AVFoundation

class VoiceRecorderViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isDisplayRemoveVoiceRecorederAlert: Bool
    @Published var isDisplayAlert: Bool
    @Published var alertMessage: String
    
    // 녹음
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording: Bool
    
    // 재생
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool
    @Published var isPaused: Bool
    @Published var playedTime: TimeInterval
    private var progressTimer: Timer?
    
    // 녹음 파일
    var recordedFiles: [URL]
    
    // 선택된 녹음 파일
    @Published var selectedRecordedFile: URL?
    
    init(
        isDisplayRemoveVoiceRecorederAlert: Bool = false,
        isDisplayAlert: Bool = false,
        errorAlertMessage: String = "",
        isRecording: Bool = false,
        isPlaying: Bool = false,
        isPaused: Bool = false,
        playedTime: TimeInterval = 0,
        recordedFiles: [URL] = [],
        selectedRecordedFile: URL? = nil
    ) {
        self.isDisplayRemoveVoiceRecorederAlert = isDisplayRemoveVoiceRecorederAlert
        self.isDisplayAlert = isDisplayAlert
        self.alertMessage = errorAlertMessage
        self.isRecording = isRecording
        self.isPlaying = isPlaying
        self.isPaused = isPaused
        self.playedTime = playedTime
        self.recordedFiles = recordedFiles
        self.selectedRecordedFile = selectedRecordedFile
    }
}

extension VoiceRecorderViewModel {
    func voiceRecordCellTapped(_ recordedFile: URL) {
        if selectedRecordedFile != recordedFile {
            stopPlaying()
            selectedRecordedFile = recordedFile
        }
    }
    
    func removeBtnTapped() {
        setIsDisplayRemoveVoiceRecorederAlert(true)
    }
    
    func removeSelectedVoiceRecord() {
        guard let fileToRemove = selectedRecordedFile, let indexToRemove = recordedFiles.firstIndex(of: fileToRemove) else {
            displayAlert(message: "삭제할 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: fileToRemove)
            recordedFiles.remove(at: indexToRemove)
            selectedRecordedFile = nil
            stopPlaying()
            displayAlert(message: "녹음 파일이 삭제되었습니다.")
        } catch {
            displayAlert(message: "녹음 파일을 삭제하는데 실패했습니다.")
        }
    }
    
    private func setIsDisplayRemoveVoiceRecorederAlert(_ isDisplay: Bool) {
        isDisplayRemoveVoiceRecorederAlert = isDisplay
    }
    
    private func setErrorAlertMessage(_ message: String) {
        alertMessage = message
    }
    
    private func setIsDisplayErrorAlert(_ isDisplay: Bool) {
        isDisplayAlert = isDisplay
    }
    
    private func displayAlert(message: String) {
        setErrorAlertMessage(message)
        setIsDisplayErrorAlert(true)
    }
}

// MARK: - 녹음
extension VoiceRecorderViewModel {
    func recordBtnTapped() {
        selectedRecordedFile = nil
        
        if isPlaying {
            stopPlaying()
            startRecording()
        } else if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    private func startRecording() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("새로운 녹음 \(recordedFiles.count + 1)")
        let settings = [ // 녹음 설정
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), // MPEG-4 AAC 코덱
            AVSampleRateKey: 12000, // 샘플링 속도
            AVNumberOfChannelsKey: 2, // 스테레오 (1: 모노, 2: 스테레오)
            AVEncoderAudioQualityKey: 7 // 오디오 품질 (0 ~ 7) (낮음 ~ 높음)
        ]
      
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.record()
            self.isRecording = true
        } catch {
            displayAlert(message: "음성메모 녹음 중 오류가 발생했습니다.")
        }
    }
    
    private func stopRecording() {
        audioRecorder?.stop()
        self.recordedFiles.append(audioRecorder!.url)
        self.isRecording = false
    }
    
    private func getDocumentsDirectory() -> URL { // 녹음 파일 저장 경로
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

// MARK: - 재생
extension VoiceRecorderViewModel {
    func startPlaying(recordingURL: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            self.isPlaying = true
            self.isPaused = false
            self.progressTimer = Timer.scheduledTimer( // 재생 시간 업데이트
                withTimeInterval: 0.1, // 0.1초마다
                repeats: true // 반복
            ) { _ in
                self.updateCurrentTime()
            }
        } catch {
            displayAlert(message: "음성메모 재생 중 오류가 발생했습니다.")
        }
    }
    
    private func updateCurrentTime() {
        self.playedTime = audioPlayer?.currentTime ?? 0
    }
    
    private func stopPlaying() {
        audioPlayer?.stop()
        playedTime = 0
        self.progressTimer?.invalidate()
        self.isPlaying = false
        self.isPaused = false
    }
    
    func pausePlaying() {
        audioPlayer?.pause()
        self.isPaused = true
        self.isPlaying = false
    }
    
    func resumePlaying() {
        audioPlayer?.play()
        self.isPaused = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        self.isPaused = false
    }
    
    func getFileInfo(for url: URL) -> (Date?, TimeInterval?) { // 파일 정보 가져오기
        let fileManager = FileManager.default
        var creationDate: Date?
        var duration: TimeInterval?
      
        do {
            let fileAttributes = try fileManager.attributesOfItem(atPath: url.path)
            creationDate = fileAttributes[.creationDate] as? Date
        } catch {
            displayAlert(message: "선택된 음성메모 파일 정보를 불러올 수 없습니다.")
        }
      
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            duration = audioPlayer.duration
        } catch {
            displayAlert(message: "선택된 음성메모 파일의 재생 시간을 불러올 수 없습니다.")
        }
      
        return (creationDate, duration)
    }
}
