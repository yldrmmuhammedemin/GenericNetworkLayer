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
    func fetchItems() {
            postManager.getPostItems { items, errorMessage in
                if let items = items {
                    self.postItems = items
                    self.viewController?.bindData(values: self.postItems)
                }
            }
    }
    
    var viewController: IViewController?
    
    func setDelegate(output: IViewController) {
        viewController = output
    }
    
    var postManager: IPostManager
    
    init(){
        postManager = PostManager()
    }
    
    var postId = 0
    var postItems = [Post]()
    var commentItems = [Comment]()
    
}
