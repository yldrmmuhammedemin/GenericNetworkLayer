//
//  PostManager.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import Foundation
class PostManager{
    static let shared = PostManager()
    
    func getPostItems(complete: @escaping(([Post]?, String?)->())){
        let url = "\(NetworkHelper.shared.baseURL)posts"
        NetworkManager.shared.request(type: [Post].self, url: url, method: .get) { response in
            switch response{
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
}
