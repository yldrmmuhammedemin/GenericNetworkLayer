//
//  PostViewModel.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import Foundation

class PostViewModel{
    var postId = 0
    var postItems = [Post]()
    var commentItems = [Comment]()
    
    func getPostItems(complete: @escaping (String?) -> ()){
        PostManager.shared.getPostItems { items, errorMessage in
            if let items = items {
                self.postItems = items
            }
            complete(errorMessage ?? "Error")
        }
    }
}
