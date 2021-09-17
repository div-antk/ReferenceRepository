//
//  ViewController.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/15.
//

import UIKit
import Instantiate
import InstantiateStandard

class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: ItemCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: ItemCollectionViewCell.reusableIdentifier)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reusableIdentifier, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }

        cell.titleLabel.text = "タイトル"
        cell.tagLabel.text = "タグです"

        return cell
    }
}
