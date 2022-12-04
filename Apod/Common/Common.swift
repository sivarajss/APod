//
//  Common.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import Foundation
import UIKit

struct Constants {
    static let Min_Date = "1995/06/16"
    static let Max_Date = "2022/12/04"
    static let Date_Format = "yyyy-MM-dd"
    static let SB_Name = "Apod"
    static let Done_Button_Title = "Done"
    static let Cancel_Button_Title = "Cancel"
    static let ToolBar_Title = "Select A Date"
    static let TabVC_Sb_Id = "TabVC"
    static let PicVC_Sb_Id = "PictureVC"
    static let FavVC_Sb_Id = "FavouriteVC"
    static let Fav_Button_Title = "Add To Favourite"
    static let Fav_Button_Selected_Title = "Added To Favourite"
    static let Goto_Fav = "Go To Favourite"
    static let PlaceHolder_Image_Title = "PlaceHolder"
    static let Reuse_ID = "Cell"
    
}

struct ApiEndpoints {
    static let url = "https://api.nasa.gov/planetary/apod?"
    static let api_key = "api_key=DEMO_KEY"
    static let date = "&date="
}

enum MyError: Error,Equatable {
    case networkError(String)
    case apiError
}

struct Utility {
    
    static func getformatedDate(dateString:String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Date_Format
        let formatedDate = formatter.date(from: dateString)!
        return formatedDate
    }
    
    static func getformatedDateString(date:Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Date_Format
        let formatedString = formatter.string(from: date)
        return formatedString
    }
}

class Singleton {
    
    static let shared = Singleton()
    lazy var favPics: [Picmodel] = []
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    private init(){}
    
    func loadImage(fromURL imageURL: URL) -> UIImage
    {
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject)
        {
            debugPrint("image loaded from cache for =\(imageURL)")
            return cachedImage
        }else if let imageData = try? Data(contentsOf: imageURL)
        {
            debugPrint("image downloaded from server...")
            if let image = UIImage(data: imageData)
            {
                self.imageCache.setObject(image, forKey: imageURL as AnyObject)
                return image
            }
        }
        return UIImage(named: Constants.PlaceHolder_Image_Title)!
    }
}

