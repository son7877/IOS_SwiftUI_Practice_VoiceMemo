//
//  Todo.swift
//  voiceMemo
//

import Foundation

struct Todo: Hashable {
    var title: String
    var time: Date
    var day: Date
    var selected: Bool
    
    var convertedDayAndTime: String {
        String("\(day.formmatedDay) - \(time.formattedTime)예정")
    }
}
