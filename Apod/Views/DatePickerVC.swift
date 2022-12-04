//
//  DatePickerVC.swift
//  Apod
//
//  Created by Sivaraj Selvaraj on 03/12/22.
//

import UIKit

class DatePickerVC: UIViewController {
    
    @IBOutlet weak var datePickerTxt: UITextField!
    let datePicker = UIDatePicker()
    
    static func create() -> UIViewController {
        let stroyboard = UIStoryboard(name: Constants.SB_Name, bundle: Bundle(for: DatePickerVC.self))
        let initialVC = stroyboard.instantiateInitialViewController() as! DatePickerVC
        return initialVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        showDatePicker()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    func showDatePicker(){
        
        //ToolBar setup
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barStyle = .black
        toolbar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: Constants.Done_Button_Title, style: .plain, target: self, action: #selector(donedatePicker));
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.height))
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.text = Constants.ToolBar_Title
        let titleLbl = UIBarButtonItem(customView: lbl)
        
        let cancelButton = UIBarButtonItem(title: Constants.Cancel_Button_Title, style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,titleLbl,spaceButton,cancelButton], animated: false)
        
        //DatePicker setup
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Utility.getformatedDate(dateString: Constants.Min_Date)
        datePicker.maximumDate = Date()
        datePickerTxt.inputAccessoryView = toolbar
        datePickerTxt.inputView = datePicker
        datePickerTxt.textAlignment = .center
        
    }
    
    @objc func donedatePicker(){
        datePickerTxt.text = Utility.getformatedDateString(date: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        if (datePickerTxt.text!.count > 1){
            let vc = PictureVC.create(picVCModelType:PictureViewModel(dataSource: PictureDataSource(apiManager: APIManager()), dateString: self.datePickerTxt.text!))
            datePickerTxt.text = nil
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
