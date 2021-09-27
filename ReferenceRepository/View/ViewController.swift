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
import Kingfisher

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

        tableView.estimatedRowHeight = 150 // 追加
        tableView.rowHeight = UITableView.automaticDimension // 追加

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

        if let article = articles?[indexPath.row] {
            cell.titleLabel.text = article.title
            cell.nameLabel.text = article.user.name
            cell.dateLabel.text = article.updated_at

            // Stringのupdated_atをDate型に変換する
            let date = DateUtil.dateFromString(string: article.updated_at)
            // Date型に変換したupdated_atをフォーマットを指定してStringに戻す
            cell.dateLabel.text = DateUtil.stringFromDate(date: date, format: "yyyy年MM月dd日")

            let imageUrl = URL(string: article.user.profile_image_url)
            cell.userImageView.kf.setImage(with: imageUrl)

            cell.likesLabel.text = String(article.likes_count)

            return cell
        } else {
            return UITableViewCell()
        }
    }
}
