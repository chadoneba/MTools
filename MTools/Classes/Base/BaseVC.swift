//
//  BaseVC.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 12.12.16.
//  Copyright © 2016 Aziz Said-Malik. All rights reserved.
//

import UIKit
import APESuperHUD

class BaseVC:UIViewController, PresenterProtocol {
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
       
        
       
        // кастомный навбар
        self.setupBackButtonAndLogo()
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg_list.png")!)
        APESuperHUD.appearance.animateInTime = 0.2
        APESuperHUD.appearance.animateOutTime = 0.2
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 223.0/255.0, green: 233.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    }
    
    
    func showError(message: String) {
        APESuperHUD.removeHUD(animated: true, presentingView: self.view)
        let alert = UIAlertController.init(title: "FS Mobile", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Закрыть", style: .default))
        self.present(alert, animated: true) {}
    }


    func connectTextFieldsToPresenter(_ map:[UITextField:(UITextField) -> Void],handler:UITextFieldDelegate) {

    }
    
    func pop() {
        guard self.navigationController != nil else {
            self.dismiss(animated: true)
            return
        }
       _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func popToTarget(_ to:[UIViewController]) {
        let conditions = to.map {
            ($0 as! BaseVC).get_storyboard_name()
        }

        let controller = self.navigationController?.viewControllers.filter {
            return conditions.contains(($0 as! BaseVC).get_storyboard_name())
        }
        
        guard controller != nil else {
            return
        }
    
        if controller!.count > 0 {
            _ = self.navigationController?.popToViewController(controller!.first!, animated: true)
        }
        
    }
    
    func showDialog(dialog: UIAlertController) {
        self.present(dialog, animated: true, completion: nil)
    }

    func reload() {
        APESuperHUD.removeHUD(animated: true, presentingView: self.view)
    }
    
    
    func route(to:UIViewController){

        if to.modalPresentationStyle == .overCurrentContext {
            if to.navigationController != nil {
                self.navigationController?.present(to, animated: true)
            } else {
                self.present(to, animated: true)
            }
        }
        else {
            self.navigationController?.pushViewController(to, animated: true)
        }
    }
    
    func get_storyboard_name()->String {
        return "NO"
    }
    
    func logOut() {
        let auth = MainRouter.TheInstance.fly_to(act: .AUTH)
        
        UIApplication.shared.delegate?.window??.rootViewController = auth
    }



    
    func set_presenter(presenter_par: RouterProtocol) {
        
    }
    
    func show_loader(){
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Идет загрузка...", presentingView: self.view)
    }

    // Проверка на зоплененость филдов
    func validationTxtField(fields: [UITextField],_ err:String) -> Bool {
        var result = false
        for field in fields {
            result = !(field.text?.isEmpty)!
            if result {
                return true
            }
            }
        if !result {
            let alert = UIAlertController(title: "FS Mobile", message: err, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: { _ in
                fields[0].becomeFirstResponder()
            }));
            self.present(alert, animated: true, completion: nil)
        }
        return result
    }


    func validateTFList<T>(fieldMap:[(T, String)]) -> Bool {
        for field in fieldMap {
            guard validationTxtField(
                    fields:field.0 as? Array<UITextField> ?? [field.0 as! UITextField],
                    field.1) else {
                return false
            }
        }
        return true
    }
   
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

