//
//  VideoChannelCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class VideoChannelCell: UITableViewCell {
    
    @IBOutlet weak var avatarImgaeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subscriberCountLabel: UILabel!
    
    var viewModel: VideoChannelCellViewModel? {
        didSet {
            setupUI()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImgaeView.layer.cornerRadius = avatarImgaeView.frame.width / 2
        avatarImgaeView.layer.masksToBounds = true
    }

    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        avatarImgaeView.setImage(url: viewModel.avatar, defaultImage: #imageLiteral(resourceName: "avatar"))
        titleLabel.text = viewModel.title
        subscriberCountLabel.text = "\(viewModel.subscriberCount.getFormatText()) lượt đăng ký"
    }
}
