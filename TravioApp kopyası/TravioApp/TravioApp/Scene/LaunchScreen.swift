//
//  LaunchScreen.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 30.08.2023.
//

import UIKit
import SnapKit

class LaunchScreen: UIViewController {
    
    private lazy var logo:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "travio-logo 1")
        
        return img
    }()
    
    
    private lazy var label:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "discoverTheWorld")
        
        return img
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.goToLoginPage()
            }

        setupView()
    }
    
    func goToLoginPage() {
            let loginViewController = LoginVC() // Giriş sayfasının olduğu kontrolör
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    


    func setupView(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(logo,label)
            
        
        setupLayouts()
        }
    
    func setupLayouts() {
        
        logo.snp.makeConstraints { make in
            make.height.equalTo(178)
            make.width.equalTo(149)
            make.top.equalToSuperview().offset(213)
            make.centerX.equalToSuperview()
           
        }
 
        label.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(238)
            
        }
    }
    
    
    

}
