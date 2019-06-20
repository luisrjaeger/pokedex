//
//  PokemonPresenterTests.swift
//  PokedexTests
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

@testable import Pokedex
import XCTest

class PokemonPresenterTests: XCTestCase {
    
    let pokemon = Pokemon(
        id: 1,
        name: "Pikachu",
        image: "img",
        types: [PokemonType.electric],
        description: "desc",
        favorite: true,
        stats: nil
    )
    
    let pokemonWithoutDescr = Pokemon(
        id: 1,
        name: "Pikachu",
        image: "img",
        types: [PokemonType.electric],
        description: nil,
        favorite: true,
        stats: nil
    )
    
    func testFetchData() {
        let expectationAnimate = XCTestExpectation(description: "")
        let expectationInformation = XCTestExpectation(description: "")
        let expectationTypes = XCTestExpectation(description: "")
        let expectationStats = XCTestExpectation(description: "")
        let expectationFavorite = XCTestExpectation(description: "")
        //let expectationLoading = XCTestExpectation(description: "")
        let view = PokemonViewMock()
        
        view.fulfillAnimate = { expectationAnimate.fulfill() }
        view.fulfillInformation = { expectationInformation.fulfill() }
        view.fulfillTypes = { expectationTypes.fulfill() }
        view.fulfillStats = { expectationStats.fulfill() }
        view.fulfillFavorite = { expectationFavorite.fulfill() }
        //view.fulfillLoading = { expectationLoading.fulfill() }
        
        let presenter = PokemonPresenter(pokemon: pokemon, view: view)
        
        presenter.viewDidLoad()
        
        wait(for: [
            expectationAnimate,
            expectationInformation,
            expectationTypes,
            expectationStats,
            expectationFavorite
            ], timeout: 1)
    }
    
    func testLoadingAnimation() {
        let expectation = XCTestExpectation(description: "")
        let view = PokemonViewMock()
        
        view.fulfillLoading = { expectation.fulfill() }
        
        let presenter = PokemonPresenter(pokemon: pokemonWithoutDescr, view: view)
        
        presenter.viewDidAppear()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFavoriteClicked() {
        let expectation = XCTestExpectation(description: "")
        let view = PokemonViewMock()
        
        view.fulfillFavorite = { expectation.fulfill() }
        
        let presenter = PokemonPresenter(pokemon: pokemonWithoutDescr, view: view)
        
        presenter.onFavoriteClicked()
        
        wait(for: [expectation], timeout: 1)
    }
    
}

typealias FulfillFunction = () -> Void

class PokemonViewMock: PokemonViewType {
   
    var fulfillAnimate: FulfillFunction?
    var fulfillInformation: FulfillFunction?
    var fulfillTypes: FulfillFunction?
    var fulfillStats: FulfillFunction?
    var fulfillFavorite: FulfillFunction?
    var fulfillLoading: FulfillFunction?
    
    func animateImageToTop() {
        fulfillAnimate?()
    }
    
    func configFirstInformation(for pokemon: Pokemon) {
        fulfillInformation?()
    }
    
    func configTypes(_ types: [PokemonType]) {
        fulfillTypes?()
    }
    
    func configStats(for pokemon: Pokemon) {
        fulfillStats?()
    }
    
    func configFavorite(checked favorite: Bool) {
        fulfillFavorite?()
    }
    
    func loadingAnimation() {
        fulfillLoading?()
    }
    
}
