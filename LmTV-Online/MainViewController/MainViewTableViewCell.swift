//
//  MainViewTableViewCell.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {

    static let cellIdentifier = "MainViewTableViewCell"
    var imageData: Data?
    
    private var starButtonIsActive = false
    
    private lazy var channelLogoImageView: UIImageView = {
            let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686275125, alpha: 1)
        imageView.layer.cornerRadius = 8
        //imageView.image = UIImage(named: "channelLogo")
            return imageView
        }()
    
    private lazy var channelNameLabel: UILabel = {
        let label = UILabel()
        label.text = "ТВ3"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private lazy var broadcastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Сверхъестественное"
        label.textColor = #colorLiteral(red: 0.9128243327, green: 0.9175701737, blue: 0.9349194765, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    
    private lazy var starButton: UIButton = {
        let button = UIButton(type: .system)
        //button.setTitle("      ╋ Добавить ребёнка      ", for: .normal)
        button.setImage(UIImage(named: "star"), for: .normal)
        //button.setTitleColor(#colorLiteral(red: 0, green: 0.6215080619, blue: 0.9352857471, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        //button.layer.cornerRadius = 5
        //button.layer.borderWidth = 4
        //button.layer.borderColor = #colorLiteral(red: 0, green: 0.6215080619, blue: 0.9352857471, alpha: 1)
        //button.layer.masksToBounds = true
        //button.layer.cornerRadius = button.frame.width / 2
        
        button.tintColor = getStarButtonTintColor()
        
        
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
//    private lazy var starImageView: UIImageView = {
//            let imageView = UIImageView()
//        imageView.image = UIImage(named: "star")
//            return imageView
//        }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.layer.cornerRadius = 10
        //contentView.layer.masksToBounds = true
        //contentView.backgroundColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        
        
        
        
        contentView.addSubview(channelLogoImageView)
        contentView.addSubview(channelNameLabel)
        contentView.addSubview(broadcastNameLabel)
        contentView.addSubview(starButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .orange
//    }
    
    

    func configure(with channelName: String, channelTitle: String) {
        channelNameLabel.text = channelName
        broadcastNameLabel.text = channelTitle
        
    }
    
    
    
    
    @objc private func starButtonTapped() {
        starButtonIsActive.toggle()
        starButton.tintColor = getStarButtonTintColor()
    }
    
    private func getStarButtonTintColor() -> UIColor {
        starButtonIsActive ? #colorLiteral(red: 0, green: 0.4610033035, blue: 1, alpha: 1) : #colorLiteral(red: 0.4501188397, green: 0.4546305537, blue: 0.48499614, alpha: 1)
    }
    
    
    
    private func setupConstraints() {
        
        
        
        channelLogoImageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    channelLogoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
                    channelLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                    channelLogoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                    channelLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    channelLogoImageView.heightAnchor.constraint(equalToConstant: 56),
                    channelLogoImageView.widthAnchor.constraint(equalToConstant: 56)
                ])
        
        channelNameLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    channelNameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -4),
                    channelNameLabel.leftAnchor.constraint(equalTo: channelLogoImageView.rightAnchor, constant: 16)
                ])
        
        broadcastNameLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    broadcastNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4),
                    broadcastNameLabel.leftAnchor.constraint(equalTo: channelNameLabel.leftAnchor),
                    broadcastNameLabel.rightAnchor.constraint(equalTo: starButton.leftAnchor, constant: -16)
                ])
        
        starButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            starButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -26),
            //starButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
            starButton.widthAnchor.constraint(equalToConstant: 24),
            starButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    
    
    
    

}
