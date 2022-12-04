//
//  PictureDataSource.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import Foundation

struct Picmodel : Decodable,Equatable {
    let title : String?
    let hdurl : String?
    let date : String?
    let explanation : String?
}

protocol PictureDataSourceProtocol {
    func getPicDatasFromApi(dateString: String,completion: @escaping (Result<Picmodel,Error>) -> Void)
}

class PictureDataSource:PictureDataSourceProtocol {
    
    private let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    
    func getPicDatasFromApi(dateString: String,completion: @escaping (Result<Picmodel, Error>) -> Void) {
        
        let url = URL(string: ApiEndpoints.url + ApiEndpoints.api_key + ApiEndpoints.date + dateString)!
        print(url)
        self.apiManager.getApiData(requestUrl: url, resultType: Picmodel.self) { result in
            completion(result)
        }
    }
    
    
}
