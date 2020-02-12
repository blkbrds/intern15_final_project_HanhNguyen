//
//  AddCommentCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class AddCommentCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    var viewModel: AddCommentCellViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }
        avatarImageView.image = UIImage(named: viewModel.avatar)
        commentTextField.text = viewModel.comment
    }
}
