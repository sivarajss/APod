//
//  APIManager.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import Foundation

class APIManager {
    
    private lazy var session: URLSession = {
        URLCache.shared.memoryCapacity = 512 * 1024 * 1024
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T,Error>)-> Void)
    {
        session.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            debugPrint("request url =\(requestUrl)")
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    debugPrint("response =\(result)")
                    completionHandler(.success(result))
                }
                catch let error{
                    debugPrint(" error  =\(error)")
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
}
