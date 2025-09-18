// SignUpPage.swift
import XCTest

class SignUpPage: BasePage {

    // MARK: - Locators (проверь id в приложении)
    private var loginField: XCUIElement { app.textFields["signUpLoginTextField"] }
    private var passwordField: XCUIElement { app.secureTextFields["signUpPasswordTextField"] }
    private var confirmField: XCUIElement { app.secureTextFields["signUpConfirmPasswordTextField"] }
    private var signUpButton: XCUIElement { app.buttons["signUpButton"] }
    private var errorLabel: XCUIElement { app.staticTexts["SignUpError"] }

    // MARK: - Actions
    @discardableResult
    func input(login: String, password: String, confirm: String) -> Self {
        XCTContext.runActivity(named: "Заполняю форму регистрации") { _ in
            loginField.tap()
            loginField.typeText(login)

            passwordField.tap()
            passwordField.typeText(password)

            confirmField.tap()
            confirmField.typeText(confirm)
        }
        return self
    }

    @discardableResult
    func submit() -> Self {
        XCTContext.runActivity(named: "Жму Sign Up") { _ in
            signUpButton.tap()
        }
        return self
    }

    // MARK: - Asserts
    func assertPrefilled(login expectedLogin: String,
                         passwordLen expectedLen: Int,
                         file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Проверяю перенесённые данные") { _ in
            XCTAssertEqual(loginField.value as? String, expectedLogin,
                           "Логин не перенесён", file: file, line: line)

            // secureTextFields не отдают пароль, но отдают строку из •••
            let actual = (passwordField.value as? String) ?? ""
            XCTAssertEqual(actual.count, expectedLen,
                           "Длина пароля не совпадает (перенос пароля мог не сработать)",
                           file: file, line: line)
        }
    }

    func assertNoError(file: StaticString = #filePath, line: UInt = #line) {
        let appeared = errorLabel.waitForExistence(timeout: 2)
        XCTAssertFalse(appeared, "Появилась ошибка регистрации: \(errorLabel.label)",
                       file: file, line: line)
    }

    func assertErrorShown(timeout: TimeInterval = 3,
                          file: StaticString = #filePath, line: UInt = #line) {
        let appeared = errorLabel.waitForExistence(timeout: timeout)
        XCTAssertTrue(appeared, "Ожидали ошибку регистрации, но не увидели",
                      file: file, line: line)
    }
}