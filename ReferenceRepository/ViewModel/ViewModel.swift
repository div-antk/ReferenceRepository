//
//  ViewModel.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/16.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

// プロトコルを適用したクラスや構造体は、プロトコルに定義されているメソッド、プロパティを必ず実装しなければならない

// VCから受ける
protocol ViewModelInputs {
    // getは読み込み専用プロパティを意味する
}

// VCに送る
protocol ViewModelOutputs {
    var articles: Observable<[Article]> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {
    
    // MARK: - input
    
    // MARK: - output
    var articles: Observable<[Article]>
    
    // MARK: - other
    
    private let disposeBag = DisposeBag()
    
    // classのプロパティの初期値を設定する
    // このクラスのインスタンスを生成する際に自動で呼び出される
    init() {
        let _articles = PublishRelay<[Article]>()
        self.articles = _articles.asObservable()
        
        // すべての記事を取得
        func getArticles() {
            AF.request("https://qiita.com/api/v2/items").responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data {
                            // 取得した[Article]をObservable型に変換
                            let articles = try decoder.decode([Article].self, from: data)
                            _articles.accept(articles)
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
    
}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { self }
    var outputs: ViewModelOutputs { self }
}
