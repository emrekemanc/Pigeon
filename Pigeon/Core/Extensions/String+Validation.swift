//
//  String+Validation.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import Foundation

extension String{
    
    
    func isValidEmail() -> ValidationError?{
        guard self.isNotEmpty else{return ValidationError.emptyEmail}
        
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        guard NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self) else {return ValidationError.invalidEmailFormat}
        
        return nil
    }
    
    func isValidPassword() -> ValidationError?{
        guard self.isNotEmpty else {return ValidationError.emptyPassword}
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`\$begin:math:display$$end:math:display$-]).{8,}$"#
        guard NSPredicate(format: "SELF MATCHES %@",passwordRegex).evaluate(with: self) else{return ValidationError.weakPassword}
        return nil
    }
    
    func isValidFullname() -> ValidationError?{
        guard self.isNotEmpty else {return ValidationError.emptyFullName}
        return nil
    }
    
    var isNotEmpty: Bool {
            return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    
}
