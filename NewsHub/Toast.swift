
import Foundation
import UIKit

class Toast {

    static func showToast(message : String, font: UIFont, index:Int, controller: UIViewController) {

        let toastLabel = UILabel(frame: CGRect(x: 90 , y: 107+index*150 , width: 130, height: 30))
    toastLabel.backgroundColor = UIColor.green.withAlphaComponent(0.8)
    toastLabel.textColor = UIColor.black
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    controller.view.addSubview(toastLabel)
    UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
}
