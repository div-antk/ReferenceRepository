//
//  DateUtilTestsQuickNimble.swift
//  ReferenceRepositoryTests
//
//  Created by Takuya Ando on 2021/10/20.
//

// Quick/Nimbleを使用した場合のテスト
import Quick
import Nimble

@testable import ReferenceRepository

class DateUtilTestsQuickNimble: QuickSpec {

    override func spec() {

        // テスト対象のメソッドを宣言
        describe("dateStringConverter()") {

            // どういう挙動になるべきか
            it("年月日形式に日付が変換される") {

                // Nimbleを使用してアサーションを記述
                expect(DateUtil.dateStringConverter(string: "2021-01-01T00:00:00+09:00"))
                    .to(equal("2021年01月01日"))
            }
            it("形式の違う日付が返ってきた際に空文字を返す") {
                expect(DateUtil.dateStringConverter(string: "2021-01-01"))
                    .to(equal(""))
            }
        }
    }
}
