import XCTest

final class SpendsUITests: TestCase {
    
    let categoryName = "TestCategory"
    func test_whenAddSpent_shouldShowSpendInList() {
        
        // Arrange
        loginPage
            .input(login: "stage258", password: "2345")
        
        // Act
        spendsPage
            .assertIsSpendsPageOpened()
            .assertIsSpendsViewAppeared()
            .addSpent()
        
        let title = UUID.randomPart
        newSpendPage
            .inputSpent(title: title, category_name: "Рыбалка")
        
        // Assert
        spendsPage
            .assertNewSpendIsShown(title: title)
    }
    
    func test_whenAddFirstSpent_shouldShowSpendInList() {
        
        // Arrange
        let login = "new_user_\(Int(Date().timeIntervalSince1970))"
        let pass  = "Qwer!2345"

        loginPage
            .goToSignUp()
            .input(login: login, password: pass, confirm: pass)
            .submit()
            .pressLoginButton()
        
        // Act
        spendsPage
            .assertIsSpendsPageOpened()
            .assertIsSpendsViewNotAppeared()
            .addSpent()
        
        let title = UUID.randomPart
        newSpendPage
            .inputSpent(title: title, category_name: categoryName)
        
        // Assert
        spendsPage
            .assertNewSpendIsShown(title: title)
    }
}

extension UUID {
    static var randomPart: String {
        UUID().uuidString.components(separatedBy: "-").first!
    }
}
