//
//  VideoDetailCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class VideoDetailCell: UITableViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var disLikeConutLabel: UILabel!

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
        viewCountLabel.text = "\(viewModel.likeConut) lượt xem"
        likeCountLabel.text = "\(viewModel.likeConut)"
        disLikeConutLabel.text = "\(viewModel.disLikeConut)"

    }
}
