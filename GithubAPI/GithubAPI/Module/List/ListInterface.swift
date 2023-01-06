//
//  ListInterface.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

protocol ListRouterInterface: RouterInterface {

}

protocol ListPresenterInterface: PresenterInterface {

}

protocol ListInteractorInterface: InteractorInterface {
    func fetchList(searched string: String)
}

protocol ListViewInterface: ViewInterface {
    
}
