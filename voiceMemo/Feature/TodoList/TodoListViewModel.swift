//
//  TodoListViewModel.swift
//  voiceMemo
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo]
    @Published var isEditTodoMode: Bool
    @Published var removeTodos: [Todo]
    @Published var isDisplayRemoveTodoAlert: Bool
    
    var removeTodosCount: Int {
        return removeTodos.count
    }
    var navigationBarRightButtonMode: NavigationBtnType {
        isEditTodoMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = [],
        isEditModeTodoMode: Bool = false,
        removeTodos: [Todo] = [],
        isDisplayRemoveTodoAlert: Bool = false
    ) {
        self.todos = todos
        self.isEditTodoMode = isEditModeTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }
}


extension TodoListViewModel {
    // 일정 박스 체크
    func selectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(where: {$0 == todo}){
            todos[index].selected.toggle()
        }
    }
    
    // 일정 등록
    func addTodo(_ todo: Todo) {
        todos.append(todo)
    }
    
    // 네비게이션 바 오른쪽 버튼
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            } else {
                setIsDisplayRemoveTodoAlert(true)
            }
        } else {
            isEditTodoMode = true
        }
    }
    
    // 일정 삭제 alert
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveTodoAlert = isDisplay
    }
    
    // 일정 완료 체크 박스 선택시
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(of: todo){
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    
    // 일정 삭제 버튼 클릭시
    func removeBtnTapped() {
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
    }
}
