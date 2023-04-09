//
//  PostManager.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import Foundation
protocol IPostManager{
    func getPostItems(complete: @escaping(([Post]?, String?)->()))
    var networkManager:INetworkManager {get}
}

class PostManager:IPostManager{
    var networkManager: INetworkManager
    
    init(){
        networkManager = NetworkManager()
    }
    
    func getPostItems(complete: @escaping(([Post]?, String?)->())){
        let url = "\(NetworkHelper.shared.baseURL)posts"
        networkManager.request(type: [Post].self, url: url, method: .get) { response in
            switch response{
            case .success(let items):
                complete(items, nil)
            case .failure(let error):
                complete(nil, error.rawValue)
            }
        }
    }
}
