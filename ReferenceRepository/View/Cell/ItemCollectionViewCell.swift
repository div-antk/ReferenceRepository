//
//  ItemCollectionViewCell.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/17.
//

import UIKit
import Instantiate
import InstantiateStandard

class ItemCollectionViewCell: UICollectionViewCell, Reusable {

    // swiftlint:disable private_outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
