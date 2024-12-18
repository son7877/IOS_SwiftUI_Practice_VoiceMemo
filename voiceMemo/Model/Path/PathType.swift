//
//  PathType.swift
//  voiceMemo
//

enum PathType :Hashable{
    
    // View Path 정의
    case homeView
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
