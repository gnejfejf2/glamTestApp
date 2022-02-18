
import UIKit

typealias FunctionCloure = (() -> ())


protocol Routing {
    func push(_ drawable : Drawable , isAnimated : Bool ,  onNavigationBack closure : FunctionCloure?)
    func pop(_ isAnimated : Bool)
    func popToRoot(_ isAnimated : Bool)
    func presentPopUp(_ drawable: Drawable, isAnimated: Bool, onDismiss closure : FunctionCloure?)
    func present(_ drawable : Drawable , isAnimated : Bool , onDismiss : FunctionCloure?)
    func dismiss(isAnimated: Bool , onDismiss closure : FunctionCloure?)
}


protocol Drawable {
    var viewController : UIViewController? { get }
}

extension UIViewController : Drawable {
   
    
    var viewController: UIViewController? { return self }
}

final class Router : NSObject {

    let navigationController : UINavigationController
    private var closures : [String : FunctionCloure] = [:]
    
    init(navigationController : UINavigationController ,  navigationBarHidden : Bool){
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(navigationBarHidden, animated: false)
        super.init()
        self.navigationController.delegate = self
    }
    
    
}


extension Router : Routing{
 
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack closure: FunctionCloure?) {
        guard let viewController = drawable.viewController else { return }
        if let closure = closure{
            closures.updateValue(closure, forKey: viewController.description)
        }
       
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    func popToRoot(_ isAnimated: Bool) {
        navigationController.popToRootViewController(animated: isAnimated)
    }
    
    //sheet올리기
    func presentPopUp(_ drawable: Drawable, isAnimated: Bool, onDismiss closure : FunctionCloure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        viewController.modalPresentationStyle = .overCurrentContext
        navigationController.present(viewController, animated: isAnimated, completion: nil)
      
    }
    
    //sheet올리기
    func sideMenuPresent(_ drawable: Drawable, isAnimated: Bool, onDismiss closure : FunctionCloure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.present(viewController, animated: isAnimated, completion: nil)
    }
    
    //sheet올리기
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss closure : FunctionCloure?) {
        guard let viewController = drawable.viewController else { return }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: isAnimated, completion: nil)
      
        viewController.presentationController?.delegate = self
    }

    //sheet올리기
    func dismiss(isAnimated: Bool , onDismiss closure : FunctionCloure? = nil) {
        navigationController.dismiss(animated: true, completion: closure)
        
    }
    

    
    func execureClosures(_ viewController : UIViewController) -> Void{
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        
        closure()
    }
    
  
    
}

extension Router : UIAdaptivePresentationControllerDelegate{
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        execureClosures(presentationController.presentedViewController)
    }
    
}


extension Router : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        guard !navigationController.viewControllers.contains(previousController) else { return }
        
        execureClosures(previousController)
    }
}

