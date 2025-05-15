//
//  CustomButton.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 13.05.2025.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 8.0
    @IBInspectable var borderWidth: CGFloat = 1.0
    @IBInspectable var borderColor: UIColor = .pigeonDark
    @IBInspectable var normalBackgroundColor: UIColor = .pigeonPrimary
    @IBInspectable var highlightedBackgroundColor: UIColor = .pigeonDark
    @IBInspectable var titleColor: UIColor = .white

    private var originalTitle: String?
    private var spinner: UIActivityIndicatorView?


    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupAppearance()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupAppearance()
    }

    private func setupAppearance() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true

        setTitleColor(titleColor, for: .normal)
        backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
    }


    override var isHighlighted: Bool {
        didSet {
            animatePressDown(isHighlighted)
        }
    }

    private func animatePressDown(_ pressed: Bool) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            self.backgroundColor = pressed ? self.highlightedBackgroundColor : self.normalBackgroundColor
            self.transform = pressed ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
        }, completion: nil)
    }

    func showLoading(_ loading: Bool, disableWhileLoading: Bool = true) {
        if loading {
            originalTitle = title(for: .normal)
            setTitle("", for: .normal)

            if spinner == nil {
                let indicator = UIActivityIndicatorView(style: .medium)
                indicator.translatesAutoresizingMaskIntoConstraints = false
                addSubview(indicator)
                NSLayoutConstraint.activate([
                    indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                    indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
                spinner = indicator
            }

            spinner?.startAnimating()
            if disableWhileLoading {
                isEnabled = false
            }

        } else {
            setTitle(originalTitle, for: .normal)
            spinner?.stopAnimating()
            if disableWhileLoading {
                isEnabled = true
            }
        }
    }
}
