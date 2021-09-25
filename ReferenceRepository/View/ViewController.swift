//
//  ViewController.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/15.
//

import UIKit
import Instantiate
import InstantiateStandard
import RxSwift
import RxCocoa

class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: ViewModel!
    private let disposeBag = DisposeBag()

    private var articles: [Article]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 領域外タップでキーボードを閉じる
        setDismissKeyboard()

        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self

        // カスタムセルを登録
        tableView.register(UINib(nibName: ItemTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.reusableIdentifier)

        getArticles()
    }

    private func getArticles() {
        viewModel = ViewModel()

        viewModel.outputs.articles
            .asObservable().subscribe { [weak self] in
                self?.articles = $0.element
                self?.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
}

extension ViewController: UISearchBarDelegate {
    // 検索ボタンを押したらキーボードを閉じる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reusableIdentifier, for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }

        return cell
    }

}

// extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reusableIdentifier, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
//
//        cell.titleLabel.text = "タイトル"
//        cell.tagLabel.text = articles?[indexPath.row].user.name
//
//        return cell
//    }
// }
