//
//  SwiftUITestUIProfileTest.swift
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
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var usernameTextField: XCUIElement {
        app.textFields["Username"]
    }
    
    var enableNotificationsToggle: XCUIElement {
        
        let container = toggleContainer(named: "Enable Notifications")
        XCTAssertTrue(container.exists, "Toggle with identifier 'Enable Notifications' not found")

        let toggleSwitch = realSwitch(in: container)
        XCTAssertTrue(toggleSwitch.exists, "Real switch inside 'Enable Notifications' not found")
        
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
    
    private func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 3) -> Bool {
        return element.waitForExistence(timeout: timeout)
    }
    
    func checkEditButtonExists() throws {
        let editButton = app.buttons["editButton"]
        XCTAssertTrue(waitForElement(editButton), "Edit button should exist")
        editButton.tap()
    }
    
    /// Sets the username in the text field.
    @discardableResult
    func setUsername(_ name: String) -> Self  {
        usernameTextField.tap()
        XCTAssertTrue(waitForElement(usernameTextField), "Username text field not found")
        usernameTextField.tap()
        app.menuItems["Select All"].tap()
        XCTAssertTrue(waitForElement(usernameTextField), "Username text field not found after select all")
        usernameTextField.typeText(name)  // 直接覆盖选中内容
        return self
    }
    
    /// Enables or disables notifications.
    @discardableResult
    func enableNotifications(_ enabled: Bool) -> Self {
        if enabled != (enableNotificationsToggle.value as? String == "1") {
            enableNotificationsToggle.tap()
        }
        return self
    }
    
    /// Selects a season photo.
    @discardableResult
    func selectSeasonPhoto(_ season: String) -> Self  {
        let pickerRow = app.cells.containing(.staticText, identifier: "Season Photos").firstMatch
        pickerRow.tap()
        
        // 在选择页面中点击对应的选项
        let option = app.buttons[season]  // 或者 app.staticTexts[season]
        XCTAssertTrue(option.waitForExistence(timeout: 3), "Season option '\(season)' not found")
        option.tap()
        return self
    }
    
    /// Interacts with the goal date picker and sets a specific date.
    @discardableResult
    func setGoalDate(_ dateString: String) -> Self  {
        let picker = goalDatePicker
        XCTAssertTrue(waitForElement(picker), "Goal date picker not found")
        
        // 轻点 DatePicker 打开日期选择界面
        picker.tap()
        
        // 等待日期轮子出现
        let firstWheel = app.pickerWheels.firstMatch
        XCTAssertTrue(firstWheel.waitForExistence(timeout: 3), "Date picker wheels not found")
        
        // 对于 DatePicker，轮子通常按以下顺序排列：Month, Day, Year
        // 目标日期：May 15
        let wheels = app.pickerWheels.allElementsBoundByIndex
        
        if wheels.count >= 2 {
            // 调整月份轮子到 May
            let monthWheel = wheels[0]
            var attempts = 0
            while !monthWheel.label.contains("May") && attempts < 12 {
                monthWheel.swipeUp()
                attempts += 1
            }
            
            // 调整日期轮子到 15
            let dayWheel = wheels[1]
            attempts = 0
            while !dayWheel.label.contains("15") && attempts < 31 {
                // 如果当前日期小于 15，向上滑动；否则向下滑动
                let currentDay = Int(dayWheel.label.trimmingCharacters(in: .whitespaces)) ?? 1
                if currentDay < 15 {
                    dayWheel.swipeUp()
                } else {
                    dayWheel.swipeDown()
                }
                attempts += 1
            }
        }
        
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
    /// Verifies the profile summary display values.
    func verifyProfileSummaryDisplay() {
        
        // 假设之前已经编辑了资料，现在回到回显界面
        XCTAssertEqual(valueForIdentifier(.name), "Edward")
        XCTAssertEqual(valueForIdentifier(.notification), "NO")
        XCTAssertEqual(valueForIdentifier(.seasonPhoto), "🍂")
        XCTAssertEqual(valueForIdentifier(.goalDate), "May 15, 2026") // 日期格式要匹配
    }
}
