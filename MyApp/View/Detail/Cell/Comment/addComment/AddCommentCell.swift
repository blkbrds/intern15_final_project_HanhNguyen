//
//  AddCommentCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class AddCommentCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var commentTextField: UITextField!

    var viewModel: AddCommentCellViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }
        avatarImageView.setImage(url: viewModel.avatar, defaultImage: #imageLiteral(resourceName: "avatar"))
        commentTextField.text = viewModel.comment
    }
}
