//
//  HomeCell.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeTableViewCellDelagete: class {
    func cell(_ cell: HomeCell, needPerformsAction action: HomeCell.Action)
}

final class HomeCell: UITableViewCell {

    @IBOutlet private weak var videoImageView: UIImageView!
    @IBOutlet private weak var durationView: UIView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var channelImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    enum Action {
        case getImageCollection(indexPath: IndexPath?)
        case getDuration(indexPath: IndexPath?)
    }
    var indexPath: IndexPath?
    weak var delegate: HomeTableViewCellDelagete?
    var viewModel: HomeCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        channelImageView.layer.cornerRadius = channelImageView.frame.width / 2
        channelImageView.layer.masksToBounds = true
        durationView.layer.cornerRadius = 3
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        videoImageView.setImage(url: viewModel.thumbnailURL)
        if let imageURL = viewModel.imageChannelURL {
            channelImageView.setImage(url: imageURL, defaultImage: #imageLiteral(resourceName: "avatar"))
        } else {
            channelImageView.image = #imageLiteral(resourceName: "avatar")
            delegate?.cell(self, needPerformsAction: .getImageCollection(indexPath: indexPath))
        }
        if let duration = viewModel.duration {
            durationLabel.text = duration.getFormattedDuration()
        } else {
            durationLabel.text = nil
            delegate?.cell(self, needPerformsAction: .getDuration(indexPath: indexPath))
        }
        titleLabel.text = viewModel.title
        descriptionLabel.text = "\(viewModel.channelTitle) • \(viewModel.createdAt.string(withFormat: App.String.dateFormatYYYYMMDDHHmmss))"
    }
}
