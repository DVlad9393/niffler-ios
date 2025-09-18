//
//  RegistrationUITests.swift
//  Niffler
//
//  Created by Владислав Дурицкий on 16.09.2025.
//


// RegistrationUITests.swift
import XCTest

final class RegistrationUITests: TestCase {

    func test_signUp_success() throws {
        launchAppWithoutLogin()

        let login = "new_user_\(Int(Date().timeIntervalSince1970))"
        let pass  = "Qwer!2345"

        loginPage
            .goToSignUp()
            .input(login: login, password: pass, confirm: pass)
            .submit()
            .pressLoginButton()
        spendsPage
            .assertIsSpendsPageOpened()
    }

    func test_loginFields_carryOver_toSignUp() throws {
        launchAppWithoutLogin()

        let login = "prefill_user"
        let pass  = "12345"

        loginPage.input_without_login(login: login, password: pass)
        let signUp = loginPage.goToSignUp()

        signUp.assertPrefilled(login: login, passwordLen: pass.count)

    }

}
