// RegistrationUITests.swift
import XCTest

final class RegistrationUITests: TestCase {

    func test_signUp_success() throws {
        launchAppWithoutLogin()

        let login = "new_user_\(Int(Date().timeIntervalSince1970))"
        let pass  = "Qwer!2345"

        // Login → Sign Up → заполнить → отправить
        loginPage
            .goToSignUp()
            .input(login: login, password: pass, confirm: pass)
            .submit()

        // Переход на главный экран после успешной регистрации
        spendsPage.assertIsSpendsViewAppeared()
    }

    func test_loginFields_carryOver_toSignUp() throws {
        launchAppWithoutLogin()

        let login = "prefill_user"
        let pass  = "12345"

        // Ввожу на экране логина, затем перехожу на регистрацию
        loginPage.input(login: login, password: pass)
        let signUp = loginPage.goToSignUp()

        // Проверяю, что логин перенесён, а длина пароля совпадает
        signUp.assertPrefilled(login: login, passwordLen: pass.count)
    }

    func test_signUp_passwordsMustMatch() throws {
        launchAppWithoutLogin()

        let login = "bad_user_\(Int(Date().timeIntervalSince1970))"
        let pass  = "Secret1!"
        let other = "Secret2!"

        loginPage
            .goToSignUp()
            .input(login: login, password: pass, confirm: other)
            .submit()

        // Ожидаем ошибку валидации
        SignUpPage(app: app).assertErrorShown()
    }
}