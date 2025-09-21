import XCTest

final class LoginUITests: TestCase {
    
    func test_loginSuccess() throws {
        launchAppWithoutLogin()

        // Act
        loginPage.input(login: "stage258", password: "2345")
        
        // Assert
        spendsPage.assertIsSpendsPageOpened()
        loginPage.assertNoErrorShown()
    }
    
    func test_loginFailure() throws {
        launchAppWithoutLogin()
        
        loginPage
            .input(login: "stage", password: "1")
            .assertIsLoginErrorShown()
    }
}
