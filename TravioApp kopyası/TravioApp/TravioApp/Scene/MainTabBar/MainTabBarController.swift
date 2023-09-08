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
        appearance.tintColor = ColorEnum.travioBackground.uiColor
        appearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7546305877)
        appearance.unselectedItemTintColor = ColorEnum.btnDefaultBackground.uiColor
        self.navigationController?.navigationBar.isHidden = true
        
        UINavigationBar.appearance().prefersLargeTitles = true
      
        let vc1 = HomeVC()
        let nav1 = UINavigationController(rootViewController: vc1)
        let img = #imageLiteral(resourceName: "home")
        let selectedImg = #imageLiteral(resourceName: "home")
        vc1.tabBarItem = UITabBarItem(title: "Home", image: img, selectedImage: selectedImg)
        
        let vc2 = VisitListVC()
        let nav2 = UINavigationController(rootViewController: vc2)
        let img2 = #imageLiteral(resourceName: "locate")
        let selectedImg2 = #imageLiteral(resourceName: "locate")
        vc2.tabBarItem = UITabBarItem(title: "Visits", image: img2, selectedImage: selectedImg2)

        
        let vc3 = MapVC()
        let nav3 = UINavigationController(rootViewController: vc3)
        let img3 = #imageLiteral(resourceName: "map")
        let selectedImg3 = #imageLiteral(resourceName: "map")
        vc3.tabBarItem = UITabBarItem(title: "Map", image: img3, selectedImage: selectedImg3)
        
        
        let vc4 = MenuVC()
        let nav4 = vc4
        let img4 = #imageLiteral(resourceName: "menu")
        let selectedImg4 = #imageLiteral(resourceName: "menu")
        vc4.tabBarItem = UITabBarItem(title: "Menu", image: img4, selectedImage: selectedImg4)
        
        
        self.viewControllers = [nav1, nav2, nav3, nav4]
        self.selectedIndex = 0
        self.view.backgroundColor = .white
    }

}

