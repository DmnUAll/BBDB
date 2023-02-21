import XCTest

final class BBDBUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testFeed() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        checkInfoAlerts()

        app.scrollViews["feedScrollView"].swipeLeft()
        app.scrollViews["feedScrollView"].swipeLeft()
        XCTAssertEqual(app.pageIndicators["feedPageControl"].value as? String, "page 3 of 5")

       checkWebView()
    }

    func testMainMenuCharacters() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["charactersButton"].isHittable)

        checkInfoAlerts()

        app.buttons["charactersButton"].tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        checkWebView()

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        checkSwipes()

        checkSearch(forText: "Zeke")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["charactersButton"].isHittable)
    }

    func testMainMenuEpisodes() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["episodesButton"].isHittable)

        app.buttons["episodesButton"].tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        checkWebView()

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        checkSwipes()

        checkSearch(forText: "Peck")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["episodesButton"].isHittable)
    }

    func testMainMenuStores() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["storesButton"].isHittable)

        app.buttons["storesButton"].tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        XCTAssertFalse(app.tables.element(boundBy: 0).isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        checkSwipes()

        checkSearch(forText: "Cats")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["storesButton"].isHittable)
    }

    func testMainMenuTrucks() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["trucksButton"].isHittable)

        app.buttons["trucksButton"].tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        XCTAssertFalse(app.tables.element(boundBy: 0).isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        checkSwipes()

        checkSearch(forText: "Vacation")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["trucksButton"].isHittable)
    }

    func testMainMenuCredits() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["creditsButton"].isHittable)

        app.buttons["creditsButton"].tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        XCTAssertFalse(app.tables.element(boundBy: 0).isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        checkSwipes()

        checkSearch(forText: "5")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["creditsButton"].isHittable)
    }

    func testMainMenuBurgers() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["burgersButton"].isHittable)

        app.buttons["burgersButton"].tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).tap()
        XCTAssertFalse(app.tables.element(boundBy: 0).isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

       checkSwipes()

        checkSearch(forText: "Mode")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.buttons["burgersButton"].isHittable)
    }

    func testTheFavorites() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 2).tap()
        let collectionView = app.collectionViews.element(boundBy: 0)
        XCTAssertTrue(collectionView.isHittable)

        checkInfoAlerts()

        collectionView.swipeUp()
        collectionView.swipeDown()
        let cell = collectionView.cells.element(boundBy: 3)
        cell.press(forDuration: 0.5)
        XCTAssertTrue(collectionView.buttons.element(boundBy: 0).isHittable)

        collectionView.buttons.element(boundBy: 0).tap()
        XCTAssertFalse(collectionView.isHittable)

        checkWebView()

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(collectionView.isHittable)

        cell.press(forDuration: 0.5)
        collectionView.buttons.element(boundBy: 1).tap()
        XCTAssertFalse(collectionView.isHittable)
    }

    func testWhoAmI() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 3).tap()
        XCTAssertTrue(app.images["makePhoto"].isHittable)

        checkInfoAlerts()

        app.images["makePhoto"].tap()
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        var alertAllowButton = springboard.buttons.element(boundBy: 1)
        if alertAllowButton.waitForExistence(timeout: 5) {
           alertAllowButton.tap()
        }
        XCTAssertFalse(app.images["makePhoto"].isHittable)

        app.buttons["PhotoCapture"].tap()
        sleep(3)
        app.buttons["Use Photo"].tap()
        XCTAssertTrue(app.images["resultPhoto"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.images["resultPhoto"].isHittable)

        app.navigationBars.buttons.element(boundBy: 1).tap()
        XCTAssertFalse(app.images["resultPhoto"].isHittable)

        app.buttons["Save Image"].tap()
        alertAllowButton = springboard.buttons.element(boundBy: 1)
        if alertAllowButton.waitForExistence(timeout: 5) {
           alertAllowButton.tap()
        }
        XCTAssertTrue(app.images["resultPhoto"].isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.images["choosePhoto"].isHittable)

        app.images["choosePhoto"].tap()
        app.scrollViews.otherElements.images.element(boundBy: 0).tap()
        sleep(3)
        XCTAssertTrue(app.images["resultPhoto"].isHittable)

        app.navigationBars.buttons.element(boundBy: 1).tap()
        XCTAssertFalse(app.images["resultPhoto"].isHittable)

        app.buttons["Save Image"].tap()
        XCTAssertTrue(app.images["resultPhoto"].isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.images["choosePhoto"].isHittable)
    }

    func testSettings() throws {
        XCTAssertTrue(app.tabBars["tabBar"].waitForExistence(timeout: 5))
        app.tabBars["tabBar"].buttons.element(boundBy: 4).tap()
        XCTAssertTrue(app.buttons["clearCacheButton"].isHittable)

        let currentSoundSwitchState = app.switches["soundSwitch"].value as? String
        let currentSplashSwitchState = app.switches["splashSwitch"].value as? String
        let currentVolume = app.sliders["volumeSlider"].normalizedSliderPosition
        app.switches["soundSwitch"].tap()
        XCTAssertNotEqual(app.switches["soundSwitch"].value as? String, currentSoundSwitchState)

        app.sliders["volumeSlider"].adjust(toNormalizedSliderPosition: 0.5)
        XCTAssertNotEqual(app.sliders["volumeSlider"].normalizedSliderPosition, currentVolume)

        app.switches["splashSwitch"].tap()
        XCTAssertNotEqual(app.switches["splashSwitch"].value as? String, currentSplashSwitchState)
    }
}

extension BBDBUITests {

    func checkInfoAlerts() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.otherElements.buttons["moduleInfo"].tap()
        XCTAssertFalse(app.navigationBars.element(boundBy: 0).isHittable)

        app.alerts.element(boundBy: 0).buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.navigationBars.element(boundBy: 0).isHittable)

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.otherElements.buttons["appInfo"].tap()
        XCTAssertFalse(app.navigationBars.element(boundBy: 0).isHittable)

        app.alerts.element(boundBy: 0).buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.navigationBars.element(boundBy: 0).isHittable)
    }

    func checkWebView() {
        app.navigationBars.buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.webViews["webView"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.webViews["webView"].isHittable)

        app.webViews["webView"].swipeDown(velocity: .fast)
        XCTAssertFalse(app.webViews["webView"].isHittable)
    }

    func checkSwipes() {
        app.tables.element(boundBy: 0).swipeUp()
        app.tables.element(boundBy: 0).swipeDown()
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 3).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 3).swipeRight()
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).buttons.element(boundBy: 0).tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).swipeRight(velocity: .fast)
        app.tables.element(boundBy: 0).cells.element(boundBy: 3).buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.alerts.element(boundBy: 0).isHittable)

        app.alerts.element(boundBy: 0).buttons.element(boundBy: 0).tap()
        XCTAssertFalse(app.alerts.element(boundBy: 0).isHittable)
    }

    func checkSearch(forText text: String) {
        app.searchFields.element(boundBy: 0).tap()
        app.searchFields.element(boundBy: 0).typeText(text)
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.element(boundBy: 0).isHittable)

        app.tables.element(boundBy: 0).cells.element(boundBy: 0).swipeRight()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).buttons.element(boundBy: 0).tap()
        app.searchFields.element(boundBy: 0).tap()
        app.searchFields.element(boundBy: 0).buttons.element(boundBy: 0).tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).swipeUp()
        XCTAssertFalse(app.keyboards.element(boundBy: 0).isHittable)
    }
}
