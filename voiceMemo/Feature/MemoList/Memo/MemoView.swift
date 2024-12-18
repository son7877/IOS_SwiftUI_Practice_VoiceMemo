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
    Text("Memo")
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
