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
    var searchWord: AnyObserver<String> { get }
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
    var searchWord: AnyObserver<String>

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
        ArticleRepository.getArticles(completion: { [weak self] response in
            _articles.accept(response)
        })
       
        let _searchWord = PublishRelay<String>()
        self.searchWord = AnyObserver<String>() { event in
            guard let text = event.element else { return }
            _searchWord.accept(text)
        }
    
        _searchWord
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { searchWord in
                ArticleRepository.searchArticles(searchWord: searchWord, completion: { [weak self] response in
                    _articles.accept(response)
                })
            }
            .subscribe(onNext: { response in
                print(response)
//                _articles.accept(response)
            })
            .disposed(by: disposeBag)
    }
}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { self }
    var outputs: ViewModelOutputs { self }
}
