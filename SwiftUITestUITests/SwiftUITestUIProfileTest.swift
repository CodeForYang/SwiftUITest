//
//  SwiftUITestUITests.swift
//  SwiftUITestUITests
//
//  Created by 杨佩 on 2026/4/28.
//

// 页面对象：个人资料设置页

import XCTest

class ProfilePage {
    private let app: XCUIApplication
    
    enum ProfileLabelType: String {
        case name = "summary_username"
        case notification = "summary_notifications"
        case seasonPhoto = "summary_season"
        case goalDate = "summary_date"
    }
    
    @discardableResult
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var usernameTextField: XCUIElement {
        app.textFields["Username"]
    }
    
    var enableNotificationsToggle: XCUIElement {
        
        let container = toggleContainer(named: "Enable Notifications")
        if !container.exists {
            print("Toggle with identifier 'Enable Notifications' not found")
        }

        let toggleSwitch = realSwitch(in: container)
        if !toggleSwitch.exists {
            print("Real switch inside 'Enable Notifications' not found")
        }
        
        return toggleSwitch
    }
    
    var seasonPhotosPicker: XCUIElement {
        app.pickers["Season Photos"]
    }
    
    var goalDatePicker: XCUIElement {
        app.datePickers["Goal Date"]
    }
    
    private func toggleContainer(named identifier: String) -> XCUIElement {
        app.descendants(matching: .any)
            .matching(NSPredicate(format: "identifier == %@", identifier))
            .firstMatch
    }

    // 2. 从容器中取出真正的 UISwitch
    private func realSwitch(in container: XCUIElement) -> XCUIElement {
        container.switches.firstMatch
    }
    
    func checkEditButtonExists() throws {
        let editButton = app.buttons["editButton"]
        let _ = editButton.waitForExistence(timeout: 3)
        XCTAssertTrue(editButton.exists, "Edit button should be exists")
        editButton.tap()
    }
    
    // 封装常用操作
    @discardableResult
    func setUsername(_ name: String) -> Self  {
        usernameTextField.tap()
        _ = usernameTextField.waitForExistence(timeout: 1)
        usernameTextField.tap()
        XCUIApplication().menuItems["Select All"].tap()
        _ = usernameTextField.waitForExistence(timeout: 1)
        usernameTextField.typeText(name)  // 直接覆盖选中内容
        return self
    }
    
    @discardableResult
    func enableNotifications(_ enabled: Bool) -> Self {
        if enabled != (enableNotificationsToggle.value as? String == "1") {
            enableNotificationsToggle.tap()
        }
        return self
    }
    
    @discardableResult
    func selectSeasonPhoto(_ season: String) -> Self  {
        let pickerRow = app.cells.containing(.staticText, identifier: "Season Photos").firstMatch
            pickerRow.tap()
            
            // 在选择页面中点击对应的选项
            let option = app.buttons[season]  // 或者 app.staticTexts[season]
            option.tap()
        return self
    }
    
    @discardableResult
    func setGoalDate(year: Int, month: Int, day: Int) -> Self  {
        goalDatePicker.tap()
        _ = goalDatePicker.waitForExistence(timeout: 1)
        
        app.buttons["Wednesday, May 6"].tap()
        return self
    }
    
    // 获取当前值的便捷属性
    private func valueForIdentifier(_ labelType: ProfileLabelType) -> String? {
        let element = app.staticTexts[labelType.rawValue]
        guard element.waitForExistence(timeout: 3) else {
            XCTFail("StaticText with identifier '\(labelType.rawValue)' not found")
            return nil
        }
        
        let fullText = element.label
        let value: String
        if let separatorRange = fullText.range(of: ": ") {
            value = String(fullText[separatorRange.upperBound...])
        } else {
            value = fullText
        }
        
        // 去掉首尾空格和换行，防止视图中的意外空格干扰
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    // 验证方法：值不对则抛出 XCTIssue（测试失败）
    func verifyProfileSummaryDisplay() {
        
        // 假设之前已经编辑了资料，现在回到回显界面
        XCTAssertEqual(valueForIdentifier(.name), "Edward")
        XCTAssertEqual(valueForIdentifier(.notification), "NO")
        XCTAssertEqual(valueForIdentifier(.seasonPhoto), "🍂")
        XCTAssertEqual(valueForIdentifier(.goalDate), "May 6, 2026") // 日期格式要匹配
    }
}
