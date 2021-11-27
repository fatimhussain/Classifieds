//
//  APIManager.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import Foundation
import Alamofire

enum ItemError: Error {
    case failure
}

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let urlString = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
    
    func loadItems(completionHandler: @escaping (ItemResponse?, Error?) -> Void) {
        //TODO: check for valid url else return

        guard let url = URL(string: urlString) else {
            completionHandler(nil, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                completionHandler(nil, ItemError.failure)
                return
            }

            do {
                let itemResponse = try JSONDecoder().decode(ItemResponse.self, from: data)
                completionHandler(itemResponse, nil)
            } catch(let error) {
                completionHandler(nil, error)
            }
        }
        task.resume()
        
//        AF.request(url, method: .get).response { response in
//            print("response::\(response)")
//            guard let data = response.data else {
//                completionHandler(nil, nil)
//                return
//            }
//
//            do {
//                let itemResponse = try JSONDecoder().decode(ItemResponse.self, from: data)
//                completionHandler(itemResponse, nil)
//            } catch(let error) {
//                completionHandler(nil, error)
//            }
//        }
    }
}
