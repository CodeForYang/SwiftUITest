//
//  SwiftUITestTests.swift
//  SwiftUITestTests
//
//  Created by 杨佩 on 2026/4/28.
//

import XCTest
@testable import SwiftUITest

final class SwiftUITestTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // MARK: - JSON Decoding

    func testLandmarkDecoding() throws {
        let url = try XCTUnwrap(
            Bundle.main.url(forResource: "landmarkData", withExtension: "json")
        )
        let data = try Data(contentsOf: url)
        let landmarks = try JSONDecoder().decode([Landmark].self, from: data)

        XCTAssertEqual(landmarks.count, 12)
        let first = landmarks[0]
        XCTAssertEqual(first.name, "Turtle Rock")
        XCTAssertEqual(first.park, "Joshua Tree National Park")
        XCTAssertEqual(first.category, .rivers)
        XCTAssertTrue(first.isFeatured)
        XCTAssertTrue(first.isFavorite)
    }

    // MARK: - Featured Landmarks

    func testModelDataFeatures() throws {
        let modelData = ModelData()
        let features = modelData.features

        XCTAssertFalse(features.isEmpty)
        for landmark in features {
            XCTAssertTrue(landmark.isFeatured)
        }
        XCTAssertLessThanOrEqual(features.count, modelData.landmarks.count)
    }

    // MARK: - Category Grouping

    func testModelDataCategories() throws {
        let modelData = ModelData()
        let categories = modelData.categories

        XCTAssertEqual(Set(categories.keys), Set(["Lakes", "Rivers", "Mountains"]))
        for (key, landmarks) in categories {
            for landmark in landmarks {
                XCTAssertEqual(landmark.category.rawValue, key)
            }
        }
        let totalGrouped = categories.values.reduce(0) { $0 + $1.count }
        XCTAssertEqual(totalGrouped, modelData.landmarks.count)
    }
}
