//
//  PostViewModel.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import Foundation

protocol IPostViewModel{
    func fetchItems()
    var postManager:IPostManager {get}
    var postItems:[Post] {get set}
    var viewController:IViewController?{get}
    func setDelegate(output:IViewController)
}

class PostViewModel:IPostViewModel{
    // MARK: - Variables
    var postManager: IPostManager
    
    init(){
        postManager = PostManager()
    }
    
    var postItems = [Post]()
    
    var viewController: IViewController?
    
    // MARK: - Fetch items from PostManager Protocol
    func fetchItems() {
            postManager.getPostItems { items, errorMessage in
                if let items = items {
                    self.postItems = items
                    self.viewController?.bindData(values: self.postItems)
                }
            }
    }
    // MARK: - Setting delegate function for ViewController
    func setDelegate(output: IViewController) {
        viewController = output
    }
    
 
    
}
