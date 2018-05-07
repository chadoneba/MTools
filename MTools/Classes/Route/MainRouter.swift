
import Foundation
import UIKit

// Протокол для обобщения разных подклассов презентеров

public protocol RouterProtocol:NSObjectProtocol {
    var delegate:PresenterProtocol? { get set }
}


// Основной класс организации роутинга

public class MainRouter {
    
    static let instance:MainRouter = MainRouter()
    
    
    public static var TheInstance : MainRouter {
        get { return instance }
    }
    
    private var storyboard = "Main"
    
    public func setStoryboard(name:String!) {
        self.storyboard = name
    }
    
    // Вся магия роутинга. Забирает из сториборда контроллер по ID и кастирует его по T из UIViewController
    // Назначает контроллер делегатом presenter, и Презентер назначает свойству презентер контроллера
    // Возвращает настроенный контроллер для использования в любом типе перехода
    
    public func getController<T:UIViewController ,U:RouterProtocol>(type_ctr:T, presenter:inout U)->T where T:PresenterProtocol {
//        let story = UIStoryboard.init(name: "Main", bundle: nil)
//        let controller = story.instantiateViewController(withIdentifier: type_ctr.get_storyboard_name()) as! T
        let controller = getController(type_ctr: type_ctr)
        presenter.delegate = controller
        controller.set_presenter(presenter_par: presenter)
        return controller
    }
    
    public func getController<T:UIViewController>(type_ctr:T)->T where T:PresenterProtocol {
        let story = UIStoryboard.init(name: self.storyboard, bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: type_ctr.get_storyboard_name()) as! T
        return controller
    }

    public func getController<T:UIViewController>(type:String)->T {
        let story = UIStoryboard.init(name: self.storyboard, bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: type) as! T
        return controller
    }
    
}


