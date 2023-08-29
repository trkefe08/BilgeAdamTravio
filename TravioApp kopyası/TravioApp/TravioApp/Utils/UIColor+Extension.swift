//
//  UIColor+Extension.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit

enum ColorEnum: String {
    case travioBackground = "#38ada9"
    case fontColor = "#3d3d3d"
    case viewColor = "#F8F8F8"
    case tfBackground  = "#FFFFFF"
    case btnDefaultBackground = "#999999"
    case addNewAnnotationVcRectangleColor = "#D9D9D9"
    case shadowColor = "#000000"
    
    var uiColor: UIColor? {
        return UIColor(hexString: rawValue)
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static func fromHex(_ hexString: String) -> UIColor? {
        return UIColor(named: hexString)
    }
    
    class func applyGradient(colors: [UIColor], bounds:CGRect) -> UIColor {
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
        
    }
    
}

enum Font {
    case poppins(fontType: Int, size: CGFloat)
    
    var font: UIFont {
        var x = ""
        switch self {
        case .poppins(let type, let size):
            
            switch type {
            case 300: x = "Light"
            case 400: x = "Regular"
            case 500: x = "Medium"
            case 600: x = "SemiBold"
            case 700: x = "Bold"
            default: x = "Light"
            }
            
            return UIFont(name: "Poppins-\(x)", size: size).ifNil(UIFont())
        }
    }
}
