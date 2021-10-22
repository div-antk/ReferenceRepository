//
//  DateUtilTests.swift
//  ReferenceRepositoryTests
//
//  Created by Takuya Ando on 2021/10/15.
//

// XCTestを使用したテスト
import XCTest

@testable import ReferenceRepository

class DateUtilTests: XCTestCase {

    func testDateStringConverter() {
        // 想定される形式の日付
        let result = DateUtil.dateStringConverter(string: "2021-01-01T00:00:00+09:00")
        let date = "2021年01月01日"

        // 想定されていない形式の日付
        let faultResult = DateUtil.dateStringConverter(string: "2021-01-01")

        XCTAssertEqual(result, date, "変換後の日付と一致しません")
        XCTAssertEqual(faultResult, "", "nilガードに失敗しています")
    }
}
