//
//  MemoListView.swift
//  voiceMemo
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if !memoListViewModel.memos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            memoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
            }
        }
    }
}

// MARK: - titleView
private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if memoListViewModel.memos.isEmpty {
                Text("No Memo")
            } else {
                Text("Memo List")
            }
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - AnnounementView
private struct AnnounementView: View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("No Memo")
                .font(.system(size: 20))
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

// MARK: - MemoListContentView
private struct MemoListConentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("Memo List")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                    
                    ForEach(memoListViewModel.memos, id: \.self) { memo in
                        MemoCellView(memo: memo)
                    }
                }
            }
        }
    }
}

// MARK: - MemoCellView
private struct MemoCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @State private var isRemoveSelected: Bool
    private var memo: Memo
    
    fileprivate init(
        isRemovedSelected: Bool = false,
        memo: Memo
    ) {
        _isRemoveSelected = State(initialValue: isRemovedSelected)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button(
            action: {
                pathModel.paths.append(.memoView(isCreateMode: false, memo: memo))
            },
            label: {
                VStack(spacing: 10) {
                    HStack{
                        VStack(alignment: .leading) {
                            Text(memo.title)
                                .lineLimit(1)
                                .font(.system(size: 16))
                                .foregroundColor(.customBlack)
                            
                            Text(memo.convertedDate)
                                .font(.system(size: 12))
                                .foregroundColor(.customGray1)
                        }
                        
                        Spacer()
                        
                        if memoListViewModel.isEditMemoMode {
                            Button(
                                action: {
                                isRemoveSelected.toggle()
                                memoListViewModel.memoRemoveSelectedBoxTapped(memo)
                                },
                                label: {
                                isRemoveSelected ? Image("selectedBox") : Image("unselectedBox")
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                }
            }
        )
    }
}

struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
