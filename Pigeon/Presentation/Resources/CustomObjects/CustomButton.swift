//
//  CustomButton.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 13.05.2025.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    // MARK: - Özellikler
    @IBInspectable var cornerRadius: CGFloat = 20
    @IBInspectable var shadowOffsetY: CGFloat = 4
    @IBInspectable var shadowOpacity: Float = 0.25
    @IBInspectable var shadowRadius: CGFloat = 4
    @IBInspectable var normalBackgroundColor: UIColor = .dark
    @IBInspectable var highlightedBackgroundColor: UIColor = .dark.withAlphaComponent(0.6)
    @IBInspectable var titleColors: UIColor = .secondary
    
    private var originalTitle: String?
    private var originalTitleColor: UIColor?
    private var spinner: UIActivityIndicatorView?
    
    // İç gölge için layer
    private var innerShadow: CAGradientLayer?

    // MARK: - Lifecycle
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
        innerShadow?.frame = bounds
        innerShadow?.cornerRadius = cornerRadius
    }

    // MARK: - Görünüm
    private func setupAppearance() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = false
        setTitleColor(titleColors, for: .normal)
        backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
        applyOuterShadow()
    }

    private func applyOuterShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 0, height: shadowOffsetY)
        layer.shadowRadius = shadowRadius
    }

    // MARK: - Highlight Durumu
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
        
        if pressed {
            removeOuterShadow()
            addInnerShadow()
        } else {
            removeInnerShadow()
            applyOuterShadow()
        }
    }

    private func removeOuterShadow() {
        layer.shadowOpacity = 0
    }

    // MARK: - İç Gölge
    private func addInnerShadow() {
        if innerShadow == nil {
            let shadow = CAGradientLayer()
            shadow.frame = bounds
            shadow.colors = [
                UIColor.black.withAlphaComponent(CGFloat(shadowOpacity)).cgColor,
                UIColor.clear.cgColor
            ]
            shadow.startPoint = CGPoint(x: 0.5, y: 0.0)
            shadow.endPoint   = CGPoint(x: 0.5, y: 0.25)
            shadow.cornerRadius = cornerRadius
            layer.addSublayer(shadow)
            innerShadow = shadow
        }
        innerShadow?.opacity = 1
    }

    private func removeInnerShadow() {
        innerShadow?.removeFromSuperlayer()
        innerShadow = nil
    }

    // MARK: - Loading
    func showLoading(_ loading: Bool, disableWhileLoading: Bool = true) {
        if loading {
            if originalTitle == nil {
                originalTitle = title(for: .normal)
                originalTitleColor = titleColor(for: .normal)
            }
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

    func resetToOriginalState(title: String) {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        spinner = nil

        setTitle(title, for: .normal)
        if let color = originalTitleColor {
            setTitleColor(color, for: .normal)
        } else {
            setTitleColor(.pigeonDark, for: .normal)
        }
        isEnabled = true
        transform = .identity
        backgroundColor = normalBackgroundColor
        applyOuterShadow()
        originalTitle = nil
        originalTitleColor = nil
    }
    
    // MARK: - Shake
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-5, 5, -4, 4, -2, 2, 0]
        layer.add(animation, forKey: "shake")
    }
}
