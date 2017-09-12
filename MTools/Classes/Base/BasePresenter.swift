//
//  BasePresenter.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 12.12.16.
//  Copyright © 2016 Aziz Said-Malik. All rights reserved.
//

import Foundation
import UIKit

public protocol PresenterProtocol {
    func reload()
    func logOut()
    func showLoader()
    func showError(message: String)
    func route(to:UIViewController)
    func pop()
    func popToTarget(_ to:[UIViewController])
    func showDialog(dialog:UIAlertController)
    func get_storyboard_name()->String
    func set_presenter(presenter_par:RouterProtocol)
}


public class BasePresenter:RouterProtocol,sessionNotification {
    var connecter:PureManager!
    var delegate:PresenterProtocol?
    var router:MainRouter?
    
    init() {
        self.connecter = PureManager.TheInstance
        self.connecter.delegate = self
    }
    
    func invalidate() {
        DispatchQueue.main.async {
            self.delegate?.logOut()
        }
    }
    
    func reload(){
        DispatchQueue.main.async {
            self.delegate?.reload()
        }
    }
    
    func pop() {
        DispatchQueue.main.async {
            self.delegate?.pop()
        }
    }
    
    func popToTarget(_ to:[UIViewController]) {
        DispatchQueue.main.async {
            self.delegate?.popToTarget(to)
        }
    }
    
    func route(to:UIViewController) {
        DispatchQueue.main.async {
            self.delegate?.route(to: to)
        }
    }


    func showDialog(dialog: UIAlertController) {
        DispatchQueue.main.async {
            self.delegate?.showDialog(dialog: dialog)
        }
    }

    func loader() {
        DispatchQueue.main.async {
            self.delegate?.showLoader()
        }
    }
    
    func showError(_ msg:String){
        DispatchQueue.main.async {
            self.delegate?.showError(message: msg)
        }
    }

    func successDialog(msg:String,reloadData:Bool = true, title:String = "", handlerOne1:@escaping ()->Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler:{ action in
            if reloadData == true {
                handlerOne1()
            } else {
                
            }
            
        })
            
            
        )
        return alert
    }
    
}
