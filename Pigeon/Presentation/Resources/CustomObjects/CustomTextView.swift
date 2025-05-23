//
//  CustomTextView.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import UIKit

@IBDesignable
class CustomTextView: UITextView {

    @IBInspectable var cornerRadius: CGFloat = 13.0
    @IBInspectable var borderWidth: CGFloat = 0.7
    @IBInspectable var borderColor: UIColor = .pigeonDark
    @IBInspectable var backgroundColors: UIColor = .pigeonBackground
    @IBInspectable var placeholder: String = "Enter message..."
    @IBInspectable var placeholderColor: UIColor = .pigeonDark
    @IBInspectable var focusShadowColor: UIColor = .black

    private var placeholderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.backgroundColor = backgroundColors.cgColor
        clipsToBounds = false
        textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        font = UIFont.systemFont(ofSize: 16)

        setupPlaceholder()
        delegate = self
    }

    private func setupPlaceholder() {
        placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = self.font
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.isHidden = !text.isEmpty
    }

    override func becomeFirstResponder() -> Bool {
        addFocusEffect()
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        removeFocusEffect()
        return super.resignFirstResponder()
    }

    private func addFocusEffect() {
        layer.shadowColor = focusShadowColor.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
    }

    private func removeFocusEffect() {
        layer.shadowOpacity = 0
    }
}

extension CustomTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
