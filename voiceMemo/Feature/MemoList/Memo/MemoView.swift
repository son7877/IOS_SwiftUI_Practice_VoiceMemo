//
//  MemoView.swift
//  voiceMemo
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @StateObject var memoViewModel: MemoViewModel
    @State var isCreateMode: Bool = true
 
  var body: some View {
      ZStack{
          VStack{
              CustomNavigationBar(
                leftBtnAction: {
                  pathModel.paths.removeLast()
                },
                rightBtnAction: {
                  if isCreateMode {
                    memoListViewModel.addMemo(memoViewModel.memo)
                  } else {
                    memoListViewModel.updateMemo(memoViewModel.memo)
                  }
                  pathModel.paths.removeLast()
                },
                rightBtnType: isCreateMode ? .create : .complete
              )
              
              MemoTitleInputView(
                memoViewModel: memoViewModel,
                isCreateMode: $isCreateMode
              )
              .padding(.top, 20)
              
              MemoContentInputView(memoViewModel: memoViewModel)
                .padding(.top, 10)
          }
          
          if !isCreateMode {
            RemoveMemoBtnView(memoViewModel: memoViewModel)
              .padding(.trailing, 20)
              .padding(.bottom, 10)
          }
      }
  }
}

// MARK: - MemoTitleInputView
private struct MemoTitleInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel // ObservedObject 이유: 뷰가 변경되어야 하는 데이터를 가지고 있기 때문에
    @FocusState private var isTitleFieldFocused: Bool // FocusState 이유: 키보드가 올라오거나 내려갈 때 포커스 상태를 관리하기 위해
    @Binding private var isCreateMode: Bool // Binding 이유: 생성모드와 수정모드를 구분하기 위해
    
    fileprivate init(memoViewModel: MemoViewModel, isCreateMode: Binding<Bool>) {
        self.memoViewModel = memoViewModel
        self._isCreateMode = isCreateMode
    }
    
    fileprivate var body: some View {
        TextField(
            "제목",
            text: $memoViewModel.memo.title
        )
        .font(.system(size: 30))
        .focused($isTitleFieldFocused)
        .padding(.horizontal, 20)
        .onAppear() {
            if isCreateMode {
                isTitleFieldFocused = true
            }
        }
    }
}

// MARK: - MemoContentInputView
private struct MemoContentInputView: View {
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
      ZStack(alignment: .topLeading) {
        TextEditor(text: $memoViewModel.memo.content)
          .font(.system(size: 20))
        
        if memoViewModel.memo.content.isEmpty {
          Text("메모를 입력하세요.")
            .font(.system(size: 16))
            .foregroundColor(.customGray1)
            .allowsHitTesting(false)
            .padding(.top, 10)
            .padding(.leading, 5)
        }
      }
      .padding(.horizontal, 20)
    }
}

// MARK: - RemoveMemoBtnView
private struct RemoveMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @ObservedObject private var memoViewModel: MemoViewModel
    
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    
    fileprivate var body: some View {
        VStack {
          Spacer()
          
          HStack {
            Spacer()
            
            Button(
              action: {
                memoListViewModel.removeMemo(memoViewModel.memo)
                pathModel.paths.removeLast()
              },
              label: {
                Image("trash")
                  .resizable()
                  .frame(width: 40, height: 40)
              }
            )
          }
        }
    }
}

struct MemoView_Previews: PreviewProvider {
  static var previews: some View {
    MemoView(
      memoViewModel: .init(
        memo: .init(
          title: "",
          content: "",
          date: Date()
        )
      )
    )
  }
}
