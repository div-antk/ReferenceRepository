//
//  ItemTableViewCell.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/25.
//

import UIKit
import Instantiate
import InstantiateStandard

class ItemTableViewCell: UITableViewCell, Reusable {

    // swiftlint:disable private_outlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        bgView.layer.cornerRadius = 8
        userImageView.layer.cornerRadius = 12
        userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
