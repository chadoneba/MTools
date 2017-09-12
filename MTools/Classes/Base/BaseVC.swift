//
//  BaseVC.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 12.12.16.
//  Copyright © 2016 Aziz Said-Malik. All rights reserved.
//

import UIKit

public class BaseVC:UIViewController, PresenterProtocol {
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    public func showLoader() {
        //TODO: override
    }

    public func hideLoader() {
        //TODO: override
    }


    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    public func showError(message: String) {

        // TODO: take name of app
        
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Закрыть", style: .default))
        self.present(alert, animated: true) {}
    }


    func connectTextFieldsToPresenter(_ map:[UITextField:(UITextField) -> Void],handler:UITextFieldDelegate) {

    }
    
    public func pop() {
        guard self.navigationController != nil else {
            self.dismiss(animated: true)
            return
        }
       _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    public func popToTarget(_ to:[UIViewController]) {
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
    
    
    public func showDialog(dialog: UIAlertController) {
        self.present(dialog, animated: true, completion: nil)
    }

    public func reload() {
        self.hideLoader()
    }
    
    
    public func route(to:UIViewController){

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
    
    public func get_storyboard_name()->String {
        return "NO"
    }
    
//    func logOut() {
//        let auth = MainRouter.TheInstance.fly_to(act: .AUTH)
//
//        UIApplication.shared.delegate?.window??.rootViewController = auth
//    }
    
    public func logOut() {
        
    }

    public func set_presenter(presenter_par: RouterProtocol) {
        
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
            // TODO: Take app name
            
            let alert = UIAlertController(title: "", message: err, preferredStyle: .alert)
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

