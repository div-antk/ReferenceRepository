//
//  ArticleRepository.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/20.
//

import Foundation
import Alamofire
import RxSwift

class ArticleRepository {
    static func getArticles() -> DataRequest {
        return AF.request("https://qiita.com/api/v2/items").responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    if let data = response.data {
                        // 取得した[Article]をObservable型に変換
                        try decoder.decode([Article].self, from: data)
    //                    _articles.accept(articles)
                    }
                } catch {
                    print("デコードに失敗")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
