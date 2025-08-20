//
//  CustomTextField.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 13.05.2025.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    // MARK: - Inspectable Özellikler
    @IBInspectable var cornerRadius: CGFloat = 25
    @IBInspectable var shadowOffsetY: CGFloat = 4
    @IBInspectable var shadowOpacity: Float = 0.25
    @IBInspectable var shadowRadius: CGFloat = 4
    @IBInspectable var textColors: UIColor = .dark
    @IBInspectable var placeholderColor: UIColor = .dark.withAlphaComponent(0.6)
    @IBInspectable var backgroundColors: UIColor = .secondary
    
    // MARK: - Error Özellikleri
    var errorColor: UIColor = .pigeonError
    var errorFont: UIFont = UIFont.systemFont(ofSize: 12)
    var errorTextColor: UIColor = .red
    private var errorLabel: UILabel?
    
    // MARK: - Inner Shadow
    private var topInnerShadow: CAGradientLayer?
    
    // MARK: - Lifecycle
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
    
    // MARK: - Customizations
    private func applyCustomizations() {
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = backgroundColors.cgColor
        textColor = textColors
        clipsToBounds = false
        
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }
        
        if !isFirstResponder {
            applyOuterShadow()
        }
    }
    
    private func applyOuterShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 0, height: shadowOffsetY)
        layer.shadowRadius = shadowRadius
    }
    
    // MARK: - Focus Kontrol
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        
        // dış gölgeyi kaldır
        layer.removeAllAnimations()
        animateShadowOpacity(to: 0)
        addTopInnerShadow()
        
        return result
    }
    
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        
        removeTopInnerShadow()
        layer.removeAllAnimations()
        animateShadowOpacity(to: shadowOpacity)
        
        return result
    }
    
    private func animateShadowOpacity(to value: Float) {
        let anim = CABasicAnimation(keyPath: "shadowOpacity")
        anim.fromValue = layer.shadowOpacity
        anim.toValue = value
        anim.duration = 0.25
        layer.shadowOpacity = value
        layer.add(anim, forKey: "shadowOpacity")
    }
    
    // MARK: - Inner Shadow
    private func addTopInnerShadow() {
        topInnerShadow?.removeFromSuperlayer()
        
        let shadow = CAGradientLayer()
        shadow.frame = bounds
        shadow.colors = [
            UIColor.black.withAlphaComponent(CGFloat(shadowOpacity)).cgColor,
            UIColor.clear.cgColor
        ]
        shadow.startPoint = CGPoint(x: 0.5, y: 0.0)
        shadow.endPoint   = CGPoint(x: 0.5, y: 0.25)
        shadow.cornerRadius = cornerRadius
        shadow.opacity = 0.0
        
        layer.addSublayer(shadow)
        topInnerShadow = shadow
        
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 0.0
        anim.toValue = 1.0
        anim.duration = 0.25
        shadow.opacity = 1.0
        shadow.add(anim, forKey: "fadeIn")
    }
    
    private func removeTopInnerShadow() {
        guard let shadow = topInnerShadow else { return }
        
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = shadow.opacity
        anim.toValue = 0.0
        anim.duration = 0.25
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            shadow.removeFromSuperlayer()
        }
        shadow.opacity = 0.0
        shadow.add(anim, forKey: "fadeOut")
        CATransaction.commit()
        
        topInnerShadow = nil
    }
    
    // MARK: - Text Insets
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: - Error Handling
    func showError(message: String) {
        guard let parent = superview else { return }
        
        // kenarlık ve gölgeyi hata rengine çevir
        layer.borderColor = errorColor.cgColor
        layer.borderWidth = 1.0
        animateShadowOpacity(to: 0.3)
        
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
        layer.borderWidth = 0
        animateShadowOpacity(to: shadowOpacity)
        
        UIView.animate(withDuration: 0.3) {
            self.errorLabel?.alpha = 0
        }
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
