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

    // 返り値がない場合があるためcompletionを使用する
    static func getArticles(completion: @escaping (_ : [Article]) -> Void) {
        AF.request("https://qiita.com/api/v2/items").responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    if let data = response.data {
                        // 取得した[Article]をObservable型に変換
                        let articles = try decoder.decode([Article].self, from: data)
                        return completion(articles)
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
