//
//  PictureVC.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import UIKit

protocol PictureVCModelType {
    func getPicDetails(date:String)
    var  dateString: String { get }
    var  delegate: PictureViewModelDelegate? { get set }
}

class PictureVC: UIViewController,PictureViewModelDelegate {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var picTitle: UILabel!
    @IBOutlet weak var pic_Details: UITextView!
    @IBOutlet weak var addToFav: UIButton!
    @IBOutlet weak var goToFav: UIButton!
    
    private var picVCModelType :PictureVCModelType!
    private var isFavButtonSelected:Bool = false
    private var favPic:Picmodel!
    var activityView: UIActivityIndicatorView?
    
    static func create(picVCModelType :PictureVCModelType) -> UIViewController {
        
        let stroyboard = UIStoryboard(name: Constants.SB_Name, bundle: Bundle(for: PictureVC.self))
        let picVC = stroyboard.instantiateViewController(withIdentifier: Constants.PicVC_Sb_Id) as! PictureVC
        picVC.picVCModelType = picVCModelType
        return picVC
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        showActivityIndicator()
        picVCModelType.getPicDetails(date: picVCModelType.dateString)
        picVCModelType.delegate = self
    }
    
    func dataToDispaly(picModel: Picmodel) {
        DispatchQueue.main.async { [weak self] in
            self?.hideActivityIndicator()
            self?.dateLbl.text = picModel.date ?? ""
            if let hdUrl = picModel.hdurl{
                self?.picture.image = Singleton.shared.loadImage(fromURL: URL(string: hdUrl)!)
            }else{
                self?.picture.image = UIImage(named: Constants.PlaceHolder_Image_Title)
            }
            self?.pic_Details.text = picModel.explanation ?? ""
            self?.picTitle.text = picModel.title ?? ""
            self?.addToFav.setTitle(Constants.Fav_Button_Title, for: .normal)
            self?.addToFav.isHidden = false
            self?.goToFav.isHidden = false
            self?.goToFav.setTitle(Constants.Fav_Button_Selected_Title, for: .normal)
        }
        favPic = picModel
    }
    
    
    
    @IBAction func addToFavAction(_ sender: Any) {
        
        if(!isFavButtonSelected){
            addToFav.setTitle(Constants.Fav_Button_Selected_Title, for: .normal)
            Singleton.shared.favPics.append(favPic)
            isFavButtonSelected = true
        }else{
            addToFav.setTitle(Constants.Fav_Button_Title, for: .normal)
            let favPics = Singleton.shared.favPics.filter { picmodel in
                return picmodel != favPic
            }
            Singleton.shared.favPics = favPics
            isFavButtonSelected = false
        }
        
    }
    
    
    @IBAction func goToFavAction(_ sender: UIButton) {
        let vc = FavouriteVC.create()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = UIColor.white
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    
}
