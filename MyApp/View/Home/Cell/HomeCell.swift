//
//  HomeCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Kingfisher

final class HomeCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var viewModel: HomeCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        channelImageView.layer.cornerRadius = channelImageView.frame.width / 2
        channelImageView.layer.masksToBounds = true
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        videoImageView.setImage(url: viewModel.thumbnailURL)
        channelImageView.setImage(url: viewModel.imageChannelURL)
        titleLabel.text = viewModel.title
        descriptionLabel.text = "\(viewModel.channelName) . \(viewModel.createdAt.string(withFormat: App.String.dateFormatYYYYMMDDHHmmss))"
    }
}
