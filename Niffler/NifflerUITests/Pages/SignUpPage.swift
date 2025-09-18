//
//  SignUpPage.swift
//  Niffler
//
//  Created by Владислав Дурицкий on 16.09.2025.
//


// SignUpPage.swift
import XCTest

class SignUpPage: BasePage {

    private var loginField: XCUIElement { app.textFields["signUp_userNameTextField"] }
    private var passwordButton: XCUIElement { app.buttons["signUp_passwordTextField"] }
    private var passwordField: XCUIElement { app.textFields["signUp_passwordTextField"] }
    private var confirmButton: XCUIElement { app.buttons["signUp_confirmPasswordTextField"] }
    private var confirmField: XCUIElement { app.textFields["signUp_confirmPasswordTextField"] }
    private var signUpButton: XCUIElement { app.buttons["Sign Up"] }
    private var errorLabel: XCUIElement { app.staticTexts["Не удалось создать пользователя"] }
    private var congratRegistrationText: XCUIElement { app.staticTexts["Congratulations!"] }
    private var succesRegistrationText: XCUIElement { app.staticTexts[" You've registered!"] }
    private var loginButon: XCUIElement { app.buttons["signUp_loginButton"] }

    // MARK: - Actions
    @discardableResult
    func input(login: String, password: String, confirm: String) -> Self {
        XCTContext.runActivity(named: "Заполняю форму регистрации") { _ in
            print(app.debugDescription)
            loginField.tap()
            loginField.typeText(login)
//            print(app.debugDescription)
            passwordButton.tap()
            passwordField.tap()
            passwordField.typeText(password)
            
            confirmButton.tap()
            confirmField.tap()
            confirmField.typeText(confirm)
            app.keyboards.buttons["Return"].tap()
        }
        return self
    }

    @discardableResult
    func submit() -> LoginPage {
        XCTContext.runActivity(named: "Жму Sign Up") { _ in
            XCTAssertTrue(signUpButton.waitForExistence(timeout: 5))
            signUpButton.tap()
            XCTAssertTrue(congratRegistrationText.waitForExistence(timeout: 5))
            XCTAssertTrue(succesRegistrationText.waitForExistence(timeout: 5))
            XCTAssertTrue(loginButon.waitForExistence(timeout: 5))
            loginButon.tap()
        }
        return LoginPage(app: app)
    }

    func assertPrefilled(login expectedLogin: String,
                         passwordLen expectedLen: Int) {
        XCTContext.runActivity(named: "Проверяю перенесённые данные") { _ in
            
            passwordButton.tap()
            passwordField.tap()
            XCTAssertTrue(loginField.waitForExistence(timeout: 3), "Поле логина не появилось")
            XCTAssertTrue(passwordField.waitForExistence(timeout: 3), "Поле пароля не появилось")

            let loginValue = (loginField.value as? String) ?? ""
            XCTAssertEqual(loginValue, expectedLogin, "Логин не перенесён")

            let raw = (passwordField.value as? String) ?? ""
            let bulletsCount = raw.filter { $0 == "•" }.count
            let effectiveLength = bulletsCount > 0 ? bulletsCount : raw.count

            XCTAssertEqual(effectiveLength, expectedLen,
                "Длина пароля не совпадает (перенос/маска могли не сработать). raw='\(raw)'")
        }
    }

}
