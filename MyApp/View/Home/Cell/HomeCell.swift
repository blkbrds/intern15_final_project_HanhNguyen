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
    func cell(_ cell: HomeCell, needPerforms action: HomeCell.Action)
}
final class HomeCell: UITableViewCell {

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var durationView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    enum Action {
        case getImageCollection(indexPath: IndexPath?)
        case getDuration(indexPath: IndexPath?)
    }
    var indexPath: IndexPath?
    var delegate: HomeTableViewCellDelagete?
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
            delegate?.cell(self, needPerforms: .getImageCollection(indexPath: indexPath))
        }
        if let duration = viewModel.duration {
            durationLabel.text = getString(durationString: duration)
        } else {
            durationLabel.text = nil
            delegate?.cell(self, needPerforms: .getDuration(indexPath: indexPath))
        }
        titleLabel.text = viewModel.title
        descriptionLabel.text = "\(viewModel.channelTitle) • \(viewModel.createdAt.string(withFormat: App.String.dateFormatYYYYMMDDHHmmss))"
    }
}

func getString(durationString: String) -> String {
    var duration: String = ""
    let string = durationString
    let stringArray = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
    for item in stringArray {
        if let number = Int(item) {
            duration += String(format: "%02d:", number)
        }
    }
    duration.remove(at: duration.index(before: duration.endIndex))
    return duration
}
