//
//  ArticleRepository.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/20.
//

import Foundation
import Alamofire
import RxSwift
import Moya

class ArticleRepository {
   
    static func getArticles() {
        private static let apiProvidor = MoyaProvider<Article>()
        private static let disposeBag = DisposeBag()
    }
    
    // 返り値がない場合があるためcompletionを使用する
    static func getArticlesAF(completion: @escaping (_ : [Article]) -> Void) {
        AF.request("https://qiita.com/api/v2/items", method: .get).responseJSON { response in
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
     
    static func searchArticlesAF(searchWord: String, completion: @escaping (_ response: [Article]) -> Void) {
        AF.request("https://qiita.com/api/v2/items?page=1&query=tag%3A\(searchWord)", method: .get).responseJSON { response in
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
