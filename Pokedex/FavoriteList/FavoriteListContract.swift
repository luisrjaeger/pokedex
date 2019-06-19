//
//  FavoriteListContract.swift
//  Pokedex
//
//  Created by Luís Ricardo Jaeger on 19/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

protocol FavoriteListViewType: AnyObject {
    func reloadData()
}

protocol FavoriteListPresenterType {
    var view: FavoriteListViewType! { get set }
    func fetchData()
    func pokemon(at index: Int) -> Pokemon
}

protocol FavoriteListInteractorInput: AnyObject {
    var output: FavoriteListInteractorOutput! { get set }
    func fetchData()
}

protocol FavoriteListInteractorOutput: AnyObject {
    func dataFetched(_ data: [Pokemon])
}
