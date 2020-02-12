//
//  CommentCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CommentCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var viewModel: CommentCellViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }
        avatarImageView.image = UIImage(named: viewModel.avatar)
        descriptionLabel.text = viewModel.name
        commentLabel.text = viewModel.comment
    }
}
