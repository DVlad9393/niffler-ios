//
//  SharedAccessibilityIdentifier.swift
//  Niffler
//
//  Created by Станислав Карпенко on 06.12.2023.
//

import Foundation

enum LoginViewIDs: String {
    case userNameTextField = "userNameTextField"
    case passwordTextField = "passwordTextField"
    case loginButton = "loginButton"
}

enum SpendsViewIDs: String {
    case spendsList = "spendsList"
    case addSpendButton = "addSpendButton"
}

enum SignUpViewIDs: String {
    case userNameTextField = "signUp_userNameTextField"
    case passwordTextField = "signUp_passwordTextField"
    case confirmPasswordTextField = "signUp_confirmPasswordTextField"
    case signUpButton = "signUpButton"
    case loginButton = "signUp_loginButton"
}
