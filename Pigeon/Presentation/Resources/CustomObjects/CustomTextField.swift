//
//  CustomTextField.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 13.05.2025.
//
import UIKit

@IBDesignable
class CustomTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 5.0
    @IBInspectable var borderWidth: CGFloat = 1.0
    @IBInspectable var borderColor: UIColor = .pigeonDark
    @IBInspectable var focusShadowColor: UIColor = .black
    @IBInspectable var placeholderColor: UIColor = .pigeonDark
    @IBInspectable var backgroundColors: UIColor = .pigeonPrimary
    var errorColor: UIColor = .pigeonError
    var errorFont: UIFont = UIFont.systemFont(ofSize: 12)
    var errorTextColor: UIColor = .red
    private var errorLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        applyCustomizations()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyCustomizations()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyCustomizations()
    }


    private func applyCustomizations() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.backgroundColor = backgroundColors.cgColor
        clipsToBounds = false

        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }
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
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        UIView.animate(withDuration: 0.15) {
            self.layer.transform = CATransform3DMakeTranslation(0, 1.5, 0)
        }
    }

    private func removeFocusEffect() {
        layer.shadowOpacity = 0

        UIView.animate(withDuration: 0.15) {
            self.layer.transform = CATransform3DIdentity
        }
    }


    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }


    func showError(message: String) {
        guard let parent = superview else { return }

        layer.borderColor = errorColor.cgColor
        layer.shadowColor = errorColor.cgColor
        layer.shadowOpacity = 0.3

        if errorLabel == nil {
            let label = UILabel()
            label.textColor = errorTextColor
            label.font = errorFont
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            parent.addSubview(label)
            errorLabel = label

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }

        errorLabel?.text = message
        errorLabel?.alpha = 0

        UIView.animate(withDuration: 0.3) {
            self.errorLabel?.alpha = 1
        }

        shake()
    }

    func hideError() {
        layer.borderColor = borderColor.cgColor
        layer.shadowOpacity = 0

        UIView.animate(withDuration: 0.3) {
            self.errorLabel?.alpha = 0
        }
    }


    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-5, 5, -4, 4, -2, 2, 0]
        layer.add(animation, forKey: "shake")
    }
}
