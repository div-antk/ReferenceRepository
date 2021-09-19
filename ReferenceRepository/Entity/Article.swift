//
//  Article.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/19.
//

import Foundation

// APIから取得したい情報をここにあらかじめ定義しておく
struct Article: Codable {
    let title: String
    var user: User

    struct User: Codable {
        var name: String
    }
}
