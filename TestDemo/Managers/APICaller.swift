//
//  APICaller.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import Foundation


struct Constants {
    static let baseURL = "https://data.taipei/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a?scope=resourceAquire"
    static let plentURL = "https://data.taipei/api/v1/dataset/f18de02f-b6c9-47c0-8cda-50efad621c14?scope=resourceAquire"
}


enum APIError: Error {
    case failedTogetData
}


class APICaller {
    
    static let shared = APICaller()
    
    func getZooDataAPI(completion: @escaping (Result<[SiteResponse], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL) else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(APIResponse.self, from: data)
                completion(.success(results.result.results))
//                print(results.result.results)
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
}
