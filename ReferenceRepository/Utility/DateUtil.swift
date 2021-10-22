//
//  DateUtil.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/27.
//

import Foundation

class DateUtil {

    static func setupEnUsPosixFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }

    // APIから取得した日付を表示用に変換する
    static func dateStringConverter(string: String) -> String {

        let formatter = DateUtil.setupEnUsPosixFormatter()
        // APIから取得したStringがISO8601形式のため、それに合わせる必要がある
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let date = formatter.date(from: string) else { return "" }
        // 表示用に変換する
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: date)
    }
}
