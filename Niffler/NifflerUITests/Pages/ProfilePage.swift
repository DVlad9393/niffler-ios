//
//  ProfilePage.swift
//  Niffler
//
//  Created by Владислав Дурицкий on 23.09.2025.
//

import XCTest

class ProfilePage: BasePage {

    private var profileLogo: XCUIElement { app.staticTexts["Profile"].firstMatch }
    private var deleteCategoryButton: XCUIElement { app.buttons["Delete"] }
    private var closeButton: XCUIElement { app.buttons["Close"] }

    // MARK: - Actions

    func deleteCategory(category: String) -> ProfilePage {
        XCTContext.runActivity(named: "Удаляю категорию") { _ in
            
            let list = app.collectionViews.firstMatch // или app.collectionViews.firstMatch
            XCTAssertTrue(list.waitForExistence(timeout: 3), "Список не появился")

            let cell = list.cells.containing(.staticText, identifier: category).firstMatch
            XCTAssertTrue(cell.waitForExistence(timeout: 3), "Ячейка '\(category)' не найдена")

            XCTAssertTrue(cell.isHittable, "Ячейка '\(category)' не видима/не кликабельна")

            cell.swipeLeft()
            
            XCTAssertTrue(deleteCategoryButton.waitForExistence(timeout: 1))
            deleteCategoryButton.tap()
            sleep(1)
            let deletedCategory = app.collectionViews.firstMatch
                .staticTexts[category].firstMatch
                
            XCTAssertFalse(deletedCategory.waitForExistence(timeout: 1), file: #file, line: #line)
            
        }
        return ProfilePage(app: app)
    }
    
    func closeProfilePage() -> SpendsPage {
        XCTContext.runActivity(named: "Закрываю экран профиля") { _ in
            closeButton.tap()
        }
        return SpendsPage(app: app)
    }
    
    @discardableResult
    func assertIsProfilePageOpened(file: StaticString = #filePath, line: UInt = #line) -> ProfilePage{
        XCTContext.runActivity(named: "Проверка открытия экрана профиля") { _ in
            XCTAssertTrue(profileLogo.waitForExistence(timeout: 5))
        }
            return ProfilePage (app: app)
    }
    
    @discardableResult
    func assertAddedCategory(expectedCategory: String) -> Self {
        XCTContext.runActivity(named: "Проверяю добавленную категорию") { _ in
            
            let isFound = app.firstMatch
                .scrollViews.firstMatch
                .staticTexts[expectedCategory].firstMatch
                .waitForExistence(timeout: 1)
            
            XCTAssertTrue(isFound, file: #file, line: #line)
            return self
        }
    }

}
