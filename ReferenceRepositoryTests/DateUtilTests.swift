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

    func testDateStringConverter() {
        let result = DateUtil.dateStringConverter(string: "2021-01-01T00:00:00+09:00")
        let date = "2021年01月01日"

        XCTAssertEqual(result, date, "変換後の日付と一致しません")
    }
}
