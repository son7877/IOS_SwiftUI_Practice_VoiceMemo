//
//  ToodoListView.swift
//  voiceMemo
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        ZStack {
            // cell list
            VStack {
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRightButtonMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                titleView()
                
                AnnounementView()
            }
        }
    }
    
//    var titleView: some View { // 프로퍼티 레퍼런스
//        Text("일정")
//            .font(.system(size: 20))
//            .fontWeight(.bold)
//    }
    
//    func titleView() -> some View { // 뷰를 리턴하는 함수 레퍼런스
//        Text("일정")
//            .font(.system(size: 20))
//            .fontWeight(.bold)
//    }
}

// MARK: - titleView
private struct titleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if todoListViewModel.todos.isEmpty {
                Text("일정이 없습니다.")
                    .foregroundColor(.customGray2)
            } else {
                Text("일정 \(todoListViewModel.todos.count)개")
            }
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - AnnounementView
private struct AnnounementView : View {
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("\"예시1\"")
            Text("\"예시2\"")
            Text("\"예시3\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}


struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}

// MARK: - TodoListContentView
private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("일정 목록")
                    .font(.system(size:16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
        }
        
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.customGray0)
                    .frame(height: 1)
                
                ForEach(todoListViewModel.todos, id: \.self) { todo in
                    // TodoCellView(todo: todo)
                }
            }
        }
    }
}


