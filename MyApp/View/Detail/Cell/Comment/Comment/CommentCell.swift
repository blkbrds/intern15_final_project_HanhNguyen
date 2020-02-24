//
//  CommentCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Kingfisher
final class CommentCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var viewModel: CommentCellViewModel? {
        didSet {
            setupUI()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }
        avatarImageView.setImage(url: viewModel.avatar)
        descriptionLabel.text = "\(viewModel.name) • \(viewModel.publishedAt.string(withFormat: App.String.dateFormatYYYYMMDDHHmmss))"
        if let comment = viewModel.comment.convertHtml() {
            commentLabel.attributedText = comment
        }
    }
}
