

import Foundation
import UIKit

public protocol PresenterProtocol:NSObjectProtocol {
    func reload()
    func logOut()
    func showLoader(_ err:Bool)
    func showError(message: String)
    func route(to:UIViewController)
    func pop()
    func popToTarget(_ to:[UIViewController])
    func showDialog(dialog:UIAlertController)
    func get_storyboard_name()->String
    func set_presenter(presenter_par:RouterProtocol)
}


open class BasePresenter:NSObject,RouterProtocol,sessionNotification {
    open var connecter:PureManager!
    weak open var delegate:PresenterProtocol?
    open var router:MainRouter?
    
    public override init() {
        super.init()
        self.connecter = PureManager.TheInstance
        self.connecter.delegate = self
    }
    
    open func invalidate() {
        DispatchQueue.main.async {
            self.delegate?.logOut()
        }
    }
    
    open func reload(){
        DispatchQueue.main.async {
            self.delegate?.reload()
        }
    }
    
    open func pop() {
        DispatchQueue.main.async {
            self.delegate?.pop()
        }
    }
    
    open func popToTarget(_ to:[UIViewController]) {
        DispatchQueue.main.async {
            self.delegate?.popToTarget(to)
        }
    }
    
    open func route(to:UIViewController) {
        DispatchQueue.main.async {
            self.delegate?.route(to: to)
        }
    }


    open func showDialog(dialog: UIAlertController) {
        DispatchQueue.main.async {
            self.delegate?.showDialog(dialog: dialog)
        }
    }

    open func loader() {
        DispatchQueue.main.async {
            self.delegate?.showLoader(false)
        }
    }
    
    open func showError(_ msg:String){
        DispatchQueue.main.async {
            self.delegate?.showError(message: msg)
        }
    }

    open func successDialog(msg:String,reloadData:Bool = true, title:String = "", handlerOne1:@escaping ()->Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "", style: .cancel, handler:{ action in
            if reloadData == true {
                handlerOne1()
            } else {
                
            }
            
        })
            
            
        )
        return alert
    }
    
}
