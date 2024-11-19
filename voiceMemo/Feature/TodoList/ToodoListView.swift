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

// MARK: - TodoCellView
private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemovedSelected: Bool
    private var todo: Todo
    
    fileprivate init(
        isRemovedSelected: Bool = false,
        todo: Todo
    ) {
        // MARK: 이 부분 다시 살펴보기
        _isRemovedSelected = State(initialValue: isRemovedSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View {
        VStack(spacing: 20) {
            HStack {
                if !todoListViewModel.isEditTodoMode {
                    Button(
                        action: {
                            todoListViewModel.selectedBoxTapped(todo)
                        },
                        label: {
                            todo.selected ? Image("selectedBox") : Image("unselectedBox")
                        }
                    )
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundStyle(todo.selected ? Color.customIconGray : .black)
                        .strikethrough(todo.selected)
                    
                    Text(todo.convertedDayAndTime)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.customIconGray)
                }
                
                Spacer()
                
                if todoListViewModel.isEditTodoMode {
                    Button(
                        action: {
                            isRemovedSelected.toggle()
                            todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                        },
                        label: {
                            isRemovedSelected ? Image("selectedBox") : Image("unselectedBox")
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}


