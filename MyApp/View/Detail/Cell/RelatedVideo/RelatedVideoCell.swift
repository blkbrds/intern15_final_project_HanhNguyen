//
//  RelatedVideoCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/10/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol RelatedVideoCellDelegate: class {
    func cell(_ cell: RelatedVideoCell, needPerforms action: RelatedVideoCell.Action)
}

final class RelatedVideoCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!

    enum Action {
        case getDuration(indexPath: IndexPath?)
    }
    weak var delegate: RelatedVideoCellDelegate?
    var indexPath: IndexPath?
    var viewModel: RelatedCellViewModel? {
        didSet {
            setupUI()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        durationView.layer.cornerRadius = 3
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }
        videoImageView.setImage(url: viewModel.imgaeURL, defaultImage: #imageLiteral(resourceName: "avatar"))
        titleLabel.text = viewModel.title
        channelNameLabel.text = viewModel.channelTitle
        if let duration = viewModel.duration {
            durationLabel.text = duration.getFormattedDuration()
        } else {
            durationLabel.text = nil
            delegate?.cell(self, needPerforms: .getDuration(indexPath: indexPath))
        }
    }
}
