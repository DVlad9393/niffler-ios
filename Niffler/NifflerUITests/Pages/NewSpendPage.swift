import XCTest

class NewSpendPage: BasePage {
    
    func inputSpent(title: String) {
        XCTContext.runActivity(named: "Ввод траты") {_ in
            inputAmount()
                .selectCategory()
                .inputDescription(title)
            //        .swipeToAddSpendsButton()
                .pressAddSpend()
        }
    }
    
    func inputAmount() -> Self {
        XCTContext.runActivity(named: "Ввод суммы") {_ in
            app.textFields["amountField"].typeText("14")
            return self
        }
    }
    
    func selectCategory() -> Self {
        XCTContext.runActivity(named: "Выбор категории") {_ in
            app.buttons["Select category"].tap()
            app.buttons["Рыбалка"].tap() // TODO: Bug
            return self
        }
    }
    
    func inputDescription(_ title: String) -> Self {
        XCTContext.runActivity(named: "Ввод описания") {_ in
            app.textFields["descriptionField"].tap()
            app.textFields["descriptionField"].typeText(title)
            return self
        }
    }
    
//    func swipeToAddSpendsButton() -> Self {
//        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
//        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
//        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
//        return self
//    }
    
    func pressAddSpend() {
        XCTContext.runActivity(named: "тап на кнопку \"Добавить") {_ in
            app.buttons["Add"].tap()
        }
    }
}
