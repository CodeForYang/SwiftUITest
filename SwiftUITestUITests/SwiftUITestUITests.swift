//
//  SwiftUITestUITests.swift
//  SwiftUITestUITests
//
//  Created by 杨佩 on 2026/4/28.
//

import XCTest

final class SwiftUITestUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Tab Switching

    /// Verifies that tapping between the "list" and "Featured" tabs
    /// displays the correct content for each tab.
    @MainActor
    func testTabSwitching() throws {
        // Tap "list" tab
        let listTab = app.tabBars.buttons["list"]
        XCTAssertTrue(listTab.exists, "List tab should exist")
        listTab.tap()

        // Verify list content is visible
        XCTAssertTrue(
            app.buttons["Turtle Rock"].exists,
            "First landmark cell should be visible in list tab"
        )

        // Tap "Featured" tab
        let featuredTab = app.tabBars.buttons["Featured"]
        XCTAssertTrue(featuredTab.exists, "Featured tab should exist")
        featuredTab.tap()

        // Verify featured content is visible
        XCTAssertTrue(
            app.staticTexts["Lakes"].exists,
            "Featured tab should show category headers"
        )
    }

    // MARK: - Landmark Navigation

    /// Verifies navigation from the landmark list to a detail view
    /// and back using the back button.
    @MainActor
    func testLandmarkNavigation() throws {
        // Switch to List tab
        app.tabBars.buttons["list"].tap()

        // Tap the first landmark cell ("Turtle Rock")
        let turtleRockCell = app.buttons["Turtle Rock"]
        XCTAssertTrue(turtleRockCell.exists, "Turtle Rock cell should exist")
        turtleRockCell.tap()

        // Assert detail view appears with expected content
        XCTAssertTrue(
            app.staticTexts["Turtle Rock"].exists,
            "Detail view should show the landmark name"
        )
        XCTAssertTrue(
            app.staticTexts["About Turtle Rock"].exists,
            "Detail view should show the About section"
        )
        XCTAssertTrue(
            app.staticTexts["Joshua Tree National Park"].exists,
            "Detail view should show the park name"
        )

        // Tap back button to return to list
        let backButton = app.navigationBars.buttons["Landmarks"]
        XCTAssertTrue(backButton.exists, "Back button 'Landmarks' should exist")
        backButton.tap()

        // Assert list is visible again
        XCTAssertTrue(
            app.buttons["Turtle Rock"].exists,
            "Landmark list should be visible after navigating back"
        )
    }

    // MARK: - Favorite Filter

    /// Verifies that toggling the "Favorites only" filter shows and hides
    /// the correct set of landmarks.
    @MainActor
    func testFavoriteFilter() throws {
        // Switch to List tab
        app.tabBars.buttons["list"].tap()

        // Locate "Favorites only" toggle
        let favoritesToggle = app.switches["Favorites only"]
        XCTAssertTrue(
            favoritesToggle.exists,
            "Favorites only toggle should exist"
        )

        // Turn toggle on
        if favoritesToggle.value as? String == "0" {
            favoritesToggle.tap()
        }

        // Verify favorited items are visible (star.fill image appears)
        XCTAssertTrue(
            app.images["star.fill"].firstMatch.exists,
            "Star fill image should be visible for favorited items"
        )

        // Turn toggle off
        favoritesToggle.tap()

        // Verify all landmarks are visible again
        XCTAssertTrue(
            app.buttons["Turtle Rock"].exists,
            "All landmarks should be visible after turning off filter"
        )
    }
}
