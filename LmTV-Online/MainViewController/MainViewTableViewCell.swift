//
//  MainViewTableViewCell.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "MainViewTableViewCell"
    
    //MARK: - Private Properties
    private var starButtonIsActive = false
    
    //MARK: - Views
    private lazy var channelLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var channelNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private lazy var broadcastNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9128243327, green: 0.9175701737, blue: 0.9349194765, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var starButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "star"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = getStarButtonTintColor()
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: - Life Circle Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(subviews: channelLogoImageView, channelNameLabel, broadcastNameLabel, starButton, activityIndicator)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configure(with channelName: String, channelTitle: String, image: String, isStarButtonActive: Bool) {
        channelNameLabel.text = channelName
        broadcastNameLabel.text = channelTitle
        
        ImageManager.shared.fetchImage(from: image) { [weak self] data in
            guard let self = self else { return }
            self.channelLogoImageView.image = UIImage(data: data)
            self.activityIndicator.stopAnimating()
        }
        
        starButtonIsActive = isStarButtonActive
        starButton.tintColor = getStarButtonTintColor()
    }
    
    //MARK: - Private Methods
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    @objc private func starButtonTapped() {
        starButtonIsActive ? deleteChannel(): saveChannel()
        starButtonIsActive.toggle()
        starButton.tintColor = getStarButtonTintColor()
    }
    
    private func saveChannel() {
        let favoriteChannel = FavoriteChannel()
        favoriteChannel.name = channelNameLabel.text ?? "No Channel Name"
        StorageManager.shared.save(favoriteChannel: favoriteChannel)
        print("В базу данных сохранено значение \(favoriteChannel.name)")
    }
    
    private func deleteChannel() {
        let favoriteChannel = FavoriteChannel()
        favoriteChannel.name = channelNameLabel.text ?? "No Channel Name"
        StorageManager.shared.delete(favoriteChannel: favoriteChannel)
        print("Из базы удалено значение \(favoriteChannel.name)")
    }
    
    private func getStarButtonTintColor() -> UIColor {
        starButtonIsActive ? #colorLiteral(red: 0, green: 0.4610033035, blue: 1, alpha: 1) : #colorLiteral(red: 0.4501188397, green: 0.4546305537, blue: 0.48499614, alpha: 1)
    }
    
    private func setupConstraints() {
        //ChannelLogoImageView
        channelLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelLogoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            channelLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            channelLogoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            channelLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            channelLogoImageView.heightAnchor.constraint(equalToConstant: 56),
            channelLogoImageView.widthAnchor.constraint(equalToConstant: 56)
        ])
        //ActivityIndicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: channelLogoImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: channelLogoImageView.centerYAnchor)
        ])
        //ChannelNameLabel
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelNameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -4),
            channelNameLabel.leftAnchor.constraint(equalTo: channelLogoImageView.rightAnchor, constant: 16),
            channelNameLabel.rightAnchor.constraint(equalTo: starButton.leftAnchor, constant: -8)
        ])
        //BroadcastNameLabel
        broadcastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            broadcastNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4),
            broadcastNameLabel.leftAnchor.constraint(equalTo: channelNameLabel.leftAnchor),
            broadcastNameLabel.rightAnchor.constraint(equalTo: starButton.leftAnchor, constant: -8)
        ])
        //StarButton
        starButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -26),
            starButton.widthAnchor.constraint(equalToConstant: 24),
            starButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
