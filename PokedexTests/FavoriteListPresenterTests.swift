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
    
    let pokemon = Pokemon(
        id: 1,
        name: "Pikachu",
        image: "img",
        types: [PokemonType.electric],
        description: "desc",
        favorite: true,
        stats: nil
    )
    
    //This test have some unknown problem u_U
    func testRemove() {
        let expectation = XCTestExpectation(description: "")
        let presenter = FavoriteListPresenter()
        let view = FavoriteListViewMock()
        
        presenter.view = view
        presenter.dataFetched([pokemon])
        
        view.fulfillData = { expectation.fulfill() }
        presenter.view = view
        
        presenter.remove(at: 0)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchData() {
        let expectation = XCTestExpectation(description: "")
        let presenter = FavoriteListPresenter()
        let view = FavoriteListViewMock()

        view.fulfillData = { expectation.fulfill() }

        presenter.view = view
        presenter.fetchData()

        wait(for: [expectation], timeout: 2)
    }
    
}

class FavoriteListViewMock: FavoriteListViewType {
    
    var fulfillData: FulfillFunction?
    var fulfillSingle: FulfillFunction?

    func reloadData() {
        fulfillData?()
    }
    
    func reloadSingleItem(at index: Int) {
        fulfillSingle?()
    }
    
}
