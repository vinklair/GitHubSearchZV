//
//  RepositoryCell.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 12..
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    func configureCell(with repositoryViewModel: RepositoryViewModel) {
        avatarImageView.kf.setImage(with: repositoryViewModel.ownerAvatarUrl)
        repositoryNameLabel.text = repositoryViewModel.repositoryName
        ownerNameLabel.text = repositoryViewModel.ownerName
        descriptionLabel.text = repositoryViewModel.description
        starsLabel.text = repositoryViewModel.stars
        languageLabel.text = repositoryViewModel.language
    }

}
