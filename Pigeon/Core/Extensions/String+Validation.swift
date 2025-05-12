//
//  String+Validation.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import Foundation

extension String{
    func isValidEmail() -> Bool{
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    func isValidPassword() -> Bool{
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`\$begin:math:display$$end:math:display$-]).{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@",passwordRegex).evaluate(with: self)
    }
    var isNotEmpty: Bool {
            return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
}
