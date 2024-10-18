//
//  CustomNavigationBar.swift
//  voiceMemo
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn: Bool
    let isDisplayRightBtn: Bool
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    let rightBtnType: NavigationBtnType
    
    init(
        isDisplayLeftBtn: Bool,
        isDisplayRightBtn: Bool ,
        leftBtnAction: @escaping () -> Void ,
        rightBtnAction: @escaping () -> Void,
        rightBtnType: NavigationBtnType
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.rightBtnType = rightBtnType
    }

    var body: some View {
        HStack{
            if isDisplayLeftBtn{
                Button(
                    action: leftBtnAction,
                    label: {Image("leftArrow")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    }
                )
            }
            
            Spacer()
            
            if isDisplayRightBtn{
                Button(
                    action: rightBtnAction,
                    label: {
                        if rightBtnType == .close{
                            Image("close")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        } else if rightBtnType == .edit{
                            Text(rightBtnType.rawValue)
                                .foregroundColor(.black)
                        } else if rightBtnType == .complete{
                            Text(rightBtnType.rawValue)
                                .foregroundColor(.black)
                        } else if rightBtnType == .create{
                            Text(rightBtnType.rawValue)
                                .foregroundColor(.black)
                        }
                    }
                )
            }
        }
        .padding(.horizontal,20)
        .frame(height: 20)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(
            isDisplayLeftBtn: true,
            isDisplayRightBtn: false,
            leftBtnAction: {},
            rightBtnAction: {} ,
            rightBtnType: .create)
    }
}
