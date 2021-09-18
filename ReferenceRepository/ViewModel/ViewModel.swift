//
//  ViewModel.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/16.
//

import Foundation
import RxSwift
import RxCocoa

// プロトコルを適用したクラスや構造体は、プロトコルに定義されているメソッド、プロパティを必ず実装しなければならない
protocol ViewModelInputs {
    // getは読み込み専用プロパティを意味する

}

protocol ViewModelOutputs {

}

protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {

    // MARK: - input

    // MARK: - output

    // MARK: - other

    private let disposeBag = DisposeBag()

    // classのプロパティの初期値を設定する
    // このクラスのインスタンスを生成する際に自動で呼び出される
    init() {

    }

}

extension ViewModel: ViewModelType {
    var inputs: ViewModelInputs { self }
    var outputs: ViewModelOutputs { self }
}
