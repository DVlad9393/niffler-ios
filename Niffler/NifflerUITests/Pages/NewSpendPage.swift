import XCTest

class NewSpendPage: BasePage {
    
    func inputSpent(title: String, category_name: String) {
        XCTContext.runActivity(named: "Ввод траты") {_ in
            inputAmount()
                .selectCategory(category_name: category_name)
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
    
    func selectCategory(category_name: String) -> Self {
        XCTContext.runActivity(named: "Выбор категории") {_ in
            app.buttons["Select category"].tap()
            let expextedAddCategoryPopup = app.alerts["Add category"].waitForExistence(timeout: 1)
            let alert = app.alerts["Add category"]
            
            
            if expextedAddCategoryPopup{
                let field = alert.textFields["Name"].exists
                ? alert.textFields["Name"]
                : alert.textFields.firstMatch
                XCTAssertTrue(field.exists, "Поле ввода в алерте не найдено", file: #file, line: #line)
                
                field.tap()
                field.typeText(category_name)
                
                let addButton = alert.buttons["Add"]
                XCTAssertTrue(addButton.exists, "Кнопка 'Add' в алерте не найдена", file: #file, line: #line)
                addButton.tap()
                
            }
            else {
                app.buttons[category_name].tap()} // TODO: Bug
        }
        return self
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
    
    func assertCategoryNotExist(category_name: String) {
        XCTContext.runActivity(named: "Проверка, что категория не существует") {_ in
            app.buttons["Select category"].tap()
            let expextedAddCategoryPopup = app.alerts["Add category"].waitForExistence(timeout: 1)
            
            if expextedAddCategoryPopup{
                XCTAssertTrue(expextedAddCategoryPopup, "Категория не добавлена", file: #file, line: #line)
                
            }
            else {
                let deletedCategory = app.firstMatch
                    .scrollViews.firstMatch
                    .staticTexts[category_name].firstMatch
                
                XCTAssertFalse(deletedCategory.waitForExistence(timeout: 1), file: #file, line: #line)}
            
        }
    }
}
