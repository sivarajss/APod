//
//  PictureViewModel.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import Foundation

protocol PictureViewModelDelegate:AnyObject {
    func dataToDispaly(picModel:Picmodel)
}

class PictureViewModel:PictureVCModelType{
    
    private let dataSource : PictureDataSourceProtocol
    weak var delegate:PictureViewModelDelegate?
    var dateString: String = ""
    
    init(dataSource:PictureDataSourceProtocol,dateString:String){
        self.dataSource = dataSource
        self.dateString = dateString
    }
    
    func getPicDetails(date:String){
        dataSource.getPicDatasFromApi(dateString: date) { [weak self] result in
                switch(result){
                case .success(let picModel):
                    self?.delegate?.dataToDispaly(picModel: picModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}
