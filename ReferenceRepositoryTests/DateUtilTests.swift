//
//  DateUtilTests.swift
//  ReferenceRepositoryTests
//
//  Created by Takuya Ando on 2021/10/15.
//

import XCTest
@testable import ReferenceRepository

class DateUtilTests: XCTestCase {

    // 共通で使用するプロパティを宣言
    var dateUtil: DateUtil!

    // 各テストメソッドごとの前処理
    override func setUp() {
        super.setUp()
        self.dateUtil = DateUtil()
    }

    // 各テストごとの後処理
    override func tearDown() {
        super.tearDown()
    }

    func testDateFromString() {
        let result = DateUtil.dateFromString(string: "2021-01-01 00:00:00 +0000")

        var calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: 2_021, month: 1, day: 1))

        print("結果", result)
        print("ひづけ", date)

        XCTAssertEqual(result, date, "型がDate型ではありません")
    }

    func testStringFromDate() {

    }
}
