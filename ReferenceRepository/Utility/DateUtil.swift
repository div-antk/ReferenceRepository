//
//  DateUtil.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/27.
//

import Foundation

class DateUtil {

    class func dateFromString(string: String) -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        formatter.formatOptions.insert(.withFractionalSeconds)
        //        let date = formatter.date(from: createdAt)
        //        formatter.calendar = Calendar(identifier: .gregorian)
        //        formatter.dateFormat = format
        return formatter.date(from: string) ?? Date()
    }

    class func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
