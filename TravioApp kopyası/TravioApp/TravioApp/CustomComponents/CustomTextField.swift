//
//  CustomTextField.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit

enum SideViewStatus {
    case left(image: UIImage)
    case right(image: UIImage)
    case none
    
    var definedSideView: UIView? {
        switch self {
        case .left(let image):
            return setSideView(icon: image)
        case .right(let image):
            return setSideView(icon: image)
        case .none:
            return nil
        }
    }
}

func setSideView(icon: UIImage? = nil) -> UIView {
    
    let imageView = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
    imageView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    imageView.image = icon
    imageView.contentMode = .scaleAspectFit
    
    let sideView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
    
    sideView.addSubview(imageView)
    
    return sideView
}



class CustomTextField: UITextField {
    
    var insets:UIEdgeInsets
    
    var sideView: SideViewStatus? = nil {
        didSet {
            defineSideViewLocation()
        }
    }
    
  

    init(insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 12)){
        self.insets = insets
        super.init(frame: .zero)
        
        let font = UIFont(name: "Poppins-Regular", size: 12)
        let attributedString = NSAttributedString(string: "Kullanıcı adınızı giriniz", attributes: [
            .foregroundColor: #colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6588235294, alpha: 1),
            .font: font
        ])
        
        self.attributedPlaceholder = attributedString
        self.textColor = #colorLiteral(red: 0.09411764706, green: 0.2901960784, blue: 0.1725490196, alpha: 1)
        self.font = UIFont(name: "Poppins-Regular", size: 12)
        //self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 0.5
//        self.layer.cornerRadius = 6
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineSideViewLocation() {
        
        switch sideView {
        case .left:
            self.leftView = sideView?.definedSideView
            self.leftViewMode = .always
        case .right:
            self.rightView = self.sideView?.definedSideView
            self.rightViewMode = .always
        case .none?:
            return
        default:
            return
        }
    }
}
