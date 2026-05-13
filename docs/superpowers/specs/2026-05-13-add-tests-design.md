# Add Unit & UI Tests to Landmarks App

2026-05-13 | Purpose: learning testing workflows

## Context

Apple SwiftUI Landmarks tutorial app with models (Landmark, Hike, Profile), an `@Observable ModelData`, and ~20 views. Test targets exist but contain only templates. The developer is an experienced iOS engineer new to testing.

## Decisions

- **Framework**: XCTest for both unit and UI tests (familiarity, industry standard)
- **Coverage**: Representative examples, not full coverage (learning goal)
- **Approach**: Vertical slice — 3 unit tests + 3 UI tests forming a complete test chain

## File Changes

| File | Action |
|---|---|
| `SwiftUITestTests/SwiftUITestTests.swift` | Rewrite: Swift Testing → XCTest, 3 test cases |
| `SwiftUITestUITests/SwiftUITestUITests.swift` | Rewrite: add 3 UI test cases |
| `SwiftUITestUITests/SwiftUITestUITestsLaunchTests.swift` | No change |

## Unit Tests

### testLandmarkDecoding
- Load `landmarkData.json` via `Bundle.main.url`, decode with `JSONDecoder`
- Assert first landmark: `name == "Turtle Rock"`, `park == "Joshua Tree National Park"`, `category == .rivers`
- Pattern: JSON decoding validation

### testModelDataFeatures
- Instantiate `ModelData()`, access `.features` computed property
- Assert all returned items have `isFeatured == true`
- Assert `features.count <= landmarks.count`
- Pattern: computed property on `@Observable` class

### testModelDataCategories
- Instantiate `ModelData()`, access `.categories` dictionary
- Assert keys contain "Lakes", "Rivers", "Mountains"
- Assert each category's landmarks match `category.rawValue`
- Pattern: dictionary grouping validation

## UI Tests

### testTabSwitching
- Launch app, tap "list" tab → assert list content visible
- Tap "Featured" tab → assert featured content visible

### testLandmarkNavigation
- Switch to List tab, tap first landmark cell
- Assert detail view appears (navigationTitle matches landmark name)
- Tap back button, assert list is visible again

### testFavoriteFilter
- Switch to List tab, tap "Favorites only" toggle
- Assert only favorited landmarks visible (star.fill icon present)
- Tap toggle off, assert all landmarks visible again

## Out of Scope

- No source code changes
- No test helpers or mocks
- No CI configuration
- No performance testing
- No SwiftData involvement
