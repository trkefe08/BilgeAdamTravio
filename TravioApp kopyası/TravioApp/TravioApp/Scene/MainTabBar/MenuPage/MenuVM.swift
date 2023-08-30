//
//  MenuVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 30.08.2023.
//

import Foundation

class MenuViewModel {
    
    var settingsCVArray: [settingsCVS] = [settingsCVS(image: "settings_securitySettings", name: "Security Settings"),
                                          settingsCVS(image: "settings_appDefaults", name: "App Defaults"),
                                          settingsCVS(image: "settings_myAddedPlaces", name: "My Added Place"),
                                          settingsCVS(image: "settings_help&support", name: "Help&Support"),
                                          settingsCVS(image: "settings_about", name: "About"),
                                          settingsCVS(image: "settings_termsOfUse", name: "Term of Use")]
    
    
    
    func countCalc() -> Int {
        return settingsCVArray.count
    }
}
