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
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    var viewModel: VideoChannelCellViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        avatarImgaeView.image = UIImage(named: viewModel.avatar)
        channelNameLabel.text = viewModel.channelName
        viewLabel.text = viewModel.view
    }
}
