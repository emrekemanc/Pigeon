//
//  ChatMessageCell.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    // MARK: - Views for sender (current user, right-aligned)
    private let senderBubbleView = UIView()
    private let senderMessageLabel = UILabel()
    private let senderTimeLabel = UILabel()

    // MARK: - Views for receiver (other user, left-aligned)
    private let receiverBubbleView = UIView()
    private let receiverMessageLabel = UILabel()
    private let receiverInitialLabel = UILabel()
    private let receiverTimeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        selectionStyle = .none

        // Sender bubble setup
        senderBubbleView.layer.cornerRadius = 18
        senderBubbleView.layer.masksToBounds = true
        senderBubbleView.backgroundColor = UIColor.systemBlue
        senderBubbleView.translatesAutoresizingMaskIntoConstraints = false

        senderMessageLabel.textColor = .white
        senderMessageLabel.numberOfLines = 0
        senderMessageLabel.translatesAutoresizingMaskIntoConstraints = false

        senderTimeLabel.font = UIFont.systemFont(ofSize: 10)
        senderTimeLabel.textColor = .white
        senderTimeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(senderBubbleView)
        senderBubbleView.addSubview(senderMessageLabel)
        senderBubbleView.addSubview(senderTimeLabel)

        // Receiver bubble setup
        receiverBubbleView.layer.cornerRadius = 18
        receiverBubbleView.layer.masksToBounds = true
        receiverBubbleView.backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        receiverBubbleView.translatesAutoresizingMaskIntoConstraints = false

        receiverMessageLabel.textColor = .black
        receiverMessageLabel.numberOfLines = 0
        receiverMessageLabel.translatesAutoresizingMaskIntoConstraints = false

        receiverInitialLabel.layer.cornerRadius = 18
        receiverInitialLabel.layer.masksToBounds = true
        receiverInitialLabel.backgroundColor = UIColor.systemGray4
        receiverInitialLabel.textColor = .darkGray
        receiverInitialLabel.textAlignment = .center
        receiverInitialLabel.font = UIFont.boldSystemFont(ofSize: 16)
        receiverInitialLabel.translatesAutoresizingMaskIntoConstraints = false

        receiverTimeLabel.font = UIFont.systemFont(ofSize: 10)
        receiverTimeLabel.textColor = .darkGray
        receiverTimeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(receiverInitialLabel)
        contentView.addSubview(receiverBubbleView)
        receiverBubbleView.addSubview(receiverMessageLabel)
        receiverBubbleView.addSubview(receiverTimeLabel)

        // Constraints

        // Sender bubble constraints
        NSLayoutConstraint.activate([
            senderBubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            senderBubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            senderBubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            senderBubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7),

            senderMessageLabel.topAnchor.constraint(equalTo: senderBubbleView.topAnchor, constant: 8),
            senderMessageLabel.leadingAnchor.constraint(equalTo: senderBubbleView.leadingAnchor, constant: 12),
            senderMessageLabel.trailingAnchor.constraint(equalTo: senderBubbleView.trailingAnchor, constant: -12),

            senderTimeLabel.topAnchor.constraint(equalTo: senderMessageLabel.bottomAnchor, constant: 4),
            senderTimeLabel.trailingAnchor.constraint(equalTo: senderBubbleView.trailingAnchor, constant: -12),
            senderTimeLabel.bottomAnchor.constraint(equalTo: senderBubbleView.bottomAnchor, constant: -8)
        ])

        // Receiver initial constraints
        NSLayoutConstraint.activate([
            receiverInitialLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            receiverInitialLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            receiverInitialLabel.widthAnchor.constraint(equalToConstant: 36),
            receiverInitialLabel.heightAnchor.constraint(equalToConstant: 36)
        ])

        // Receiver bubble constraints
        NSLayoutConstraint.activate([
            receiverBubbleView.leadingAnchor.constraint(equalTo: receiverInitialLabel.trailingAnchor, constant: 8),
            receiverBubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            receiverBubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            receiverBubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7),

            receiverMessageLabel.topAnchor.constraint(equalTo: receiverBubbleView.topAnchor, constant: 8),
            receiverMessageLabel.leadingAnchor.constraint(equalTo: receiverBubbleView.leadingAnchor, constant: 12),
            receiverMessageLabel.trailingAnchor.constraint(equalTo: receiverBubbleView.trailingAnchor, constant: -12),

            receiverTimeLabel.topAnchor.constraint(equalTo: receiverMessageLabel.bottomAnchor, constant: 4),
            receiverTimeLabel.trailingAnchor.constraint(equalTo: receiverBubbleView.trailingAnchor, constant: -12),
            receiverTimeLabel.bottomAnchor.constraint(equalTo: receiverBubbleView.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Configuration
    func cellConfigure(message: MessageCredentials, selfUser: UserCredentials) {
        // Hide both bubbles initially
        senderBubbleView.isHidden = true
        senderMessageLabel.isHidden = true
        senderTimeLabel.isHidden = true
        receiverBubbleView.isHidden = true
        receiverMessageLabel.isHidden = true
        receiverInitialLabel.isHidden = true
        receiverTimeLabel.isHidden = true

        if selfUser.id == message.sender_id {
            senderBubbleView.isHidden = false
            senderMessageLabel.isHidden = false
            senderTimeLabel.isHidden = false
            senderMessageLabel.text = message.text
            senderTimeLabel.text = formatTimestamp(message.created_at)
        } else {
            receiverBubbleView.isHidden = false
            receiverMessageLabel.isHidden = false
            receiverInitialLabel.isHidden = false
            receiverTimeLabel.isHidden = false
            receiverMessageLabel.text = message.text
            receiverTimeLabel.text = formatTimestamp(message.created_at)
            receiverInitialLabel.text = initialForName(selfUser.fullname)
        }
    }

    // MARK: - Helpers
    private func initialForName(_ name: String?) -> String {
        guard let name = name, let first = name.first else { return "?" }
        return String(first).uppercased()
    }

    private func formatTimestamp(_ timestamp: Date?) -> String {
        guard let timestamp = timestamp else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: timestamp)
    }
}
