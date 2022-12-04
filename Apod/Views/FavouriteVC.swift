//
//  FavouriteVC.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import UIKit

class FavouriteVC: UIViewController {

    @IBOutlet weak var favTblView: UITableView!
    
    static func create() -> UIViewController {
        let stroyboard = UIStoryboard(name: Constants.SB_Name, bundle: Bundle(for: DatePickerVC.self))
        let favVC = stroyboard.instantiateViewController(withIdentifier: Constants.FavVC_Sb_Id) as! FavouriteVC
        return favVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTblView.delegate = self
        favTblView.dataSource = self
    }
}

extension FavouriteVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.shared.favPics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.Reuse_ID)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: Constants.Reuse_ID)
            }
        let picDetail = Singleton.shared.favPics[indexPath.row]
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.text = picDetail.title ?? ""
        cell?.imageView?.contentMode = .scaleAspectFill
        if let hdUrl = picDetail.hdurl{
            cell?.imageView?.image = Singleton.shared.loadImage(fromURL: URL(string: hdUrl)!)
        }else{
            cell?.imageView?.image = UIImage(named: Constants.PlaceHolder_Image_Title)
        }
        return cell!
    }

    
}
