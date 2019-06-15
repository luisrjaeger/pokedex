//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Luís Ricardo Jaeger on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import XCTest
@testable import Pokedex

class PokedexTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let jsonURL = Bundle(for: PokedexTests.self).url(forResource: "pokemons_v2", withExtension: "json")!
        let data = try! Data(contentsOf: jsonURL)
        
        //print(String(data: data, encoding: .utf8))
        //RequestMaker()
        
        XCTAssertNoThrow(try RequestMaker.decoder.decode(PokemonResponse.self, from: data))
    }

}
