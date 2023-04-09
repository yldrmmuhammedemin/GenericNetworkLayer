//
//  NetworkManager.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import Foundation
import Alamofire
protocol INetworkManager{
    
    func urlSessionRequest<T:Codable>(type:T.Type,
                            url: String,
                            method: HTTPMethods,
                            completion: @escaping(
                                (Result<T,ErrorTypes>)->())
    )
    
    func alamofireRequest<T:Codable>(type:T.Type,
                            url: String,
                            method: HTTPMethod,
                            completion: @escaping(
                                (Result<T,ErrorTypes>)->())
    )
}

class NetworkManager:INetworkManager{

    
    func urlSessionRequest<T:Codable>(type:T.Type,
                            url: String,
                            method: HTTPMethods,
                            completion: @escaping(
                                (Result<T,ErrorTypes>)->())
    ){
        let session = URLSession.shared
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            let dataTask = session.dataTask(with: request){
                data, response, error in
                if let _ = error{
                    completion(.failure(.generalError))
                }else if let data = data{
                    self.handleResponse(data: data) { response in
                        completion(response)
                    }
                }else{
                    completion(.failure(.invalidURL))
                }
            }
            dataTask.resume()
        }
    }
    
    func alamofireRequest<T:Codable>(type:T.Type,
                                     url: String,
                                     method: HTTPMethod,
                                     completion: @escaping(
                                        (Result<T,ErrorTypes>)->())
    ){
        AF.request(url, method: method).responseData { response in
            switch response.result{
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
            case .failure(_):
                completion(.failure(.generalError))
            }
        }
    }
    func handleResponse<T:Codable>(data:Data, completion: @escaping(Result<T, ErrorTypes>) -> ()){
        do{
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        }catch{
            completion(.failure(.invalidData))
        }
    }
}
