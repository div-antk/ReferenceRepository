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

        searchBar.rx.text.orEmpty
            .filter { $0.count >= 1 }
            .bind(to: viewModel.inputs.searchWord)
            .disposed(by: disposeBag)
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
        articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.reusableIdentifier, for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }

        if let article = articles?[indexPath.row] {
            cell.titleLabel.text = article.title

            // 名前を設定してないユーザはIDを表示する
            if article.user.name.isEmpty {
                cell.nameLabel.text = "@\(article.user.id)"
            } else {
                cell.nameLabel.text = article.user.name
            }

            // Stringのupdated_atをDate型に変換する
            let date = DateUtil.dateFromString(string: article.updated_at)
            // Date型に変換したupdated_atをフォーマットを指定してStringに戻す
            cell.dateLabel.text = DateUtil.stringFromDate(date: date, format: "yyyy年MM月dd日")

            // プロフィール画像の設定
            let imageUrl = URL(string: article.user.profile_image_url)
            cell.userImageView.kf.setImage(with: imageUrl)

            cell.likesLabel.text = String(article.likes_count)

            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // WebViewのVCにURLを渡してモーダル遷移する
        if let url = URL(string: articles?[indexPath.row].url ?? "") {
            let webVc = WebViewController.instantiate(with: WebViewController.Dependency(url: url))

            // iOS15でモーダルの仕様が変わり、ハンドルを表示してあげないとスワイプで閉じることができない
            if #available(iOS 15.0, *) {
                if let sheet = webVc.sheetPresentationController {
                    sheet.prefersGrabberVisible = true
                }
            } else {
                // Fallback on earlier versions
            }

            self.present(webVc, animated: true)
        }
    }
}
