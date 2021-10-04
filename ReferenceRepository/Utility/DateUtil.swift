//
//  DateUtil.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/27.
//

import Foundation

class DateUtil {

    static func dateFromString(string: String) -> Date {
        let formatter = ISO8601DateFormatter()
        // TODO: バグ回避のためにタイムゾーンを修正する
        let timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.timeZone = timeZone
        formatter.formatOptions.insert(.withFractionalSeconds)
        return formatter.date(from: string) ?? Date()
    }

    static func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
