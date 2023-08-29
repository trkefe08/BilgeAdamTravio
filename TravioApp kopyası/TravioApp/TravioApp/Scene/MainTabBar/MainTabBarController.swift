//
//  MainTabBarController.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBar.appearance()
        
        let appearanceSelectedColor = ColorEnum.travioBackground
        if let color = appearanceSelectedColor.uiColor {
            appearance.tintColor = color
        }
        
        appearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7546305877)
        let selectedColor = ColorEnum.btnDefaultBackground
        if let colorValue = selectedColor.uiColor {
            appearance.unselectedItemTintColor = colorValue
        }
        
        UINavigationBar.appearance().prefersLargeTitles = true
      
        let vc1 = HomeVC()
        let img = #imageLiteral(resourceName: "home")
        let selectedImg = #imageLiteral(resourceName: "home")
        vc1.tabBarItem = UITabBarItem(title: "Home", image: img, selectedImage: selectedImg)
        
        let vc2 = UINavigationController(rootViewController: VisitListVC())
        let img2 = #imageLiteral(resourceName: "locate")
        let selectedImg2 = #imageLiteral(resourceName: "locate")
        vc2.tabBarItem = UITabBarItem(title: "Visits", image: img2, selectedImage: selectedImg2)

        
        let vc3 = MapVC()
        let img3 = #imageLiteral(resourceName: "map")
        let selectedImg3 = #imageLiteral(resourceName: "map")
        vc3.tabBarItem = UITabBarItem(title: "Map", image: img3, selectedImage: selectedImg3)
        
        
        let vc4 = MenuVC()
        let img4 = #imageLiteral(resourceName: "menu")
        let selectedImg4 = #imageLiteral(resourceName: "menu")
        vc4.tabBarItem = UITabBarItem(title: "Menu", image: img4, selectedImage: selectedImg4)

        
        self.viewControllers = [vc1, vc2, vc3, vc4]
        self.selectedIndex = 1
        self.view.backgroundColor = .white
    }

}

