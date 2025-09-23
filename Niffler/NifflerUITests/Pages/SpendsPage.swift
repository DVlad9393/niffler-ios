import XCTest

class SpendsPage: BasePage {
    func assertIsSpendsViewAppeared(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Жду экран с тратами") { _ in
            waitSpendsScreen(file: file, line: line)
            XCTAssertGreaterThanOrEqual(app.scrollViews.switches.count, 1,
                                        "Не нашел трат в списке",
                                        file: file, line: line)
        }
            return self
    }
    func assertIsSpendsViewNotAppeared(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Жду экран без трат") { _ in
            let isNotFound = app.firstMatch
                .scrollViews.firstMatch
                .switches.firstMatch
                .waitForExistence(timeout: 3)
            
            XCTAssertFalse(isNotFound,
                          "На экране найдена трата",
                          file: file, line: line)
        }
            return self
    }
    
    @discardableResult
    func assertIsSpendsPageOpened(file: StaticString = #filePath, line: UInt = #line) -> Self{
        XCTContext.runActivity(named: "Проверка открытия экрана с тратами") { _ in
            XCTAssertTrue(app.staticTexts["Statistics"].waitForExistence(timeout: 5))
        }
            return self
    }
    
    @discardableResult
    func waitSpendsScreen(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Ожидаю экран с тратами") {_ in
            let isFound = app.firstMatch
                .scrollViews.firstMatch
                .switches.firstMatch
                .waitForExistence(timeout: 10)
            
            XCTAssertTrue(isFound,
                          "Не дождались экрана со списком трат",
                          file: file, line: line)
        }
            return self
    }
    
    @discardableResult
    func addSpent() -> Self {
        XCTContext.runActivity(named: "Тап на кнопку добавления траты"){_ in
            app.buttons["addSpendButton"].tap()
        }
            return self
    }
    
    @discardableResult
    func openProfile() -> Self {
        XCTContext.runActivity(named: "Открыть профиль"){_ in
            app.images["ic_menu"].firstMatch.press(forDuration: 0.1)
            sleep(1)
            XCTAssertTrue(app.buttons["Profile"].firstMatch.waitForExistence(timeout: 2), file: #file, line: #line)
            XCTAssertTrue(app.buttons["Profile"].firstMatch.isEnabled, file: #file, line: #line)
            app.buttons["Profile"].firstMatch.tap()
        }
            return self
    }
    
    func assertNewSpendIsShown(title: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Проверяю наличие новой траты") {_ in
            
            let isFound = app.firstMatch
                .scrollViews.firstMatch
                .staticTexts[title].firstMatch
                .waitForExistence(timeout: 1)
            
            XCTAssertTrue(isFound, file: file, line: line)
        }
    }
}
