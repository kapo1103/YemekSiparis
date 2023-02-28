//
//  YemekSepetRouter.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

class YemekSepetRouter : PresenterToRouterYemekSepetprotocol {
    
    static func createModule(ref: YemekSepet) {
        
        let presenter = YemekSepetPresenter()
                
        ref.yemekSepetPresenterNesnesi = presenter
        ref.yemekSepetPresenterNesnesi?.yemekSepetInteractor = YemekSepetInteractor()

        ref.yemekSepetPresenterNesnesi?.yemekSepetView = ref
        ref.yemekSepetPresenterNesnesi?.yemekSepetInteractor?.yemekSepetPresenter = presenter
        
    }
}
