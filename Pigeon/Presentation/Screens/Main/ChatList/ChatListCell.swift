//
//  ChatListCell.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

import UIKit

class ChatListCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondarySystemBackground
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let initialsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = UIColor.systemGray4
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = .tertiaryLabel
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Setup Layout
    private func setupViews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(initialsLabel)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(lastMessageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            initialsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            initialsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            initialsLabel.widthAnchor.constraint(equalToConstant: 50),
            initialsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            usernameLabel.leadingAnchor.constraint(equalTo: initialsLabel.trailingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -8),
            usernameLabel.bottomAnchor.constraint(lessThanOrEqualTo: lastMessageLabel.topAnchor, constant: -6),
            
            lastMessageLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 6),
            lastMessageLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            lastMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            lastMessageLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -14),
            
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            timeLabel.widthAnchor.constraint(equalToConstant: 65),
            
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initialsLabel.layer.cornerRadius = initialsLabel.frame.height / 2
        initialsLabel.clipsToBounds = true
        self.layoutIfNeeded()
    }
}
