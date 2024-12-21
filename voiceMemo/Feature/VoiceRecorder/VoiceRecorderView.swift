//
//  VoiceRecorderView.swift
//  voiceMemo
//

import SwiftUI

struct VoiceRecorderView: View {
    @StateObject private var viewModel = VoiceRecorderViewModel()
    
    var body: some View {
        Text("Voice Recorder View")
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



struct VoiceRecorderView_Previews: PreviewProvider {
  static var previews: some View {
    VoiceRecorderView()
  }
}
