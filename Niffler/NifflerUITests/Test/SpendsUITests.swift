import XCTest

final class SpendsUITests: TestCase {
    
    func test_whenAddSpent_shouldShowSpendInList() {
        launchAppWithoutLogin()
        
        // Arrange
        loginPage
            .input(login: "stage258", password: "2345")
        
        // Act
        spendsPage
            .assertIsSpendsPageOpened()
            .addSpent()
        
        let title = UUID.randomPart
        newSpendPage
            .inputSpent(title: title)
        
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
