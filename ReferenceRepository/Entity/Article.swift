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
    let likes_count: Int
    let updated_at: String
    let url: String
    let user: User

    struct User: Codable {
        let name: String
        let profile_image_url: String
    }
}
