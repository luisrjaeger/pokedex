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

    func testDecoding() {
        let jsonURL = Bundle(for: PokedexTests.self).url(forResource: "pokemons_v2", withExtension: "json")!
        let data = try! Data(contentsOf: jsonURL)
    
        XCTAssertNoThrow(try RequestMaker.decoder.decode(PokemonResponse.self, from: data))
    }
    
    func testRequestList() {
        let expectation = XCTestExpectation(description: "")
        
        let requestMaker = RequestMaker()
        requestMaker.make(withEndpoint: .list) { (list: PokemonList) in
            XCTAssertGreaterThan(list.pokemons.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testRequestThrowsDecodingError() {
        let expectation = XCTestExpectation(description: "")
        
        let requestMaker = RequestMaker()
        requestMaker.make(withEndpoint: .list) { (result: RequestMaker.RequestResult<Pokemon>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .decodingFailed)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
//    func testRequestThrowsRequestFailed() {
//        let expectation = XCTestExpectation(description: "")
//
//        let requestMaker = RequestMaker()
//        requestMaker.make(withEndpoint: .move(query: "chora")) { (result: RequestMaker.RequestResult<Move>) in
//            switch result {
//            case .success:
//                XCTFail()
//            case .failure(let error):
//                XCTAssertEqual(error, .requestFailed)
//            }
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 2)
//    }

}
