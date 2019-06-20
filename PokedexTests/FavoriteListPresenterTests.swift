//
//  FavoriteListPresenterTests.swift
//  PokedexTests
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

@testable import Pokedex
import XCTest

class FavoriteListPresenterTests: XCTestCase {
    
    func testFetchData() {
        let expectation = XCTestExpectation(description: "")
        let presenter = FavoriteListPresenter()
        let view = FavoriteListViewMock {
            expectation.fulfill()
        }
        
        presenter.view = view
        presenter.fetchData()
        
        wait(for: [expectation], timeout: 2)
    }
    
}

class FavoriteListViewMock: FavoriteListViewType {
    
    let fulfill: () -> Void
    
    init(fulfill: @escaping () -> Void) {
        self.fulfill = fulfill
    }
    
    func reloadData() {
        fulfill()
    }
    
    func reloadSingleItem(at index: Int) {
        fulfill()
    }
    
}
