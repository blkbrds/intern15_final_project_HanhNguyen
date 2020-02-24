//
//  VideoDetailCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class VideoDetailCell: UITableViewCell {

    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var viewCountLabel: UILabel!
    @IBOutlet private weak var likeCountLabel: UILabel!
    @IBOutlet private weak var disLikeConutLabel: UILabel!

    var viewModel: VideoDetailCellViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        tagLabel.text = viewModel.tag
        titleLabel.text = viewModel.title
        viewCountLabel.text = "\(viewModel.viewCount.getFormatText()) lượt xem"
        likeCountLabel.text = viewModel.likeCount.getFormatText()
        disLikeConutLabel.text = viewModel.disLikeCount.getFormatText()
    }
}
