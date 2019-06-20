//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Luís Ricardo Jaeger on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import XCTest

class PokedexUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
    }

    func testPokemonList() {
        let cells = app.descendants(matching: .cell)
        let firstCell = cells.firstMatch
        firstCell.tap()

        XCTAssertTrue(app.otherElements["detailView"].waitForExistence(timeout: 1))

        //app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.buttons["ic path"].tap()

    }
    
    func testMoveList() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Moves"].tap()
        
        XCTAssert(app.navigationBars["Move"].exists)
    }
    
    func testMoveDetail() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Moves"].tap()
        
        let cells = app.descendants(matching: .cell)
        let firstCell = cells.firstMatch
        firstCell.tap()
        
        XCTAssertTrue(app.staticTexts["Base Power"].waitForExistence(timeout: 1))
    }
    
    func testItemList() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Items"].tap()
        
        XCTAssert(app.navigationBars["Item"].exists)
    }
    
    func testFavorites() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Favorites"].tap()
        
        XCTAssert(app.navigationBars["Favorite"].exists)
    }
    
    func testFavoritesItem() {
        let list = app.descendants(matching: .cell)
        let firstItem = list.firstMatch
        firstItem.swipeRight()
        
        firstItem.buttons["Favorite"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Favorites"].tap()
        
        let cells = app.descendants(matching: .cell)
        let firstCell = cells.firstMatch
        firstCell.tap()
        
        //????
        //XCTAssert(app.navigationBars["Favorite"].exists)
    }

}
