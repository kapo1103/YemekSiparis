//
//  YemekDetayRouter.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

class YemekDetayRouter : PresenterToRouterYemekDetayProtocol {
    static func createModule(ref: YemekDetay) {
        
        let presenter = YemekDetayPresenter()
        
        //View
        ref.yemekDetayPresenterNesnesi = presenter
        
        //Presenter
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = YemekDetayInteractor()
        
        ref.yemekDetayPresenterNesnesi?.yemekDetayView = ref

        //Interactor
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor?.yemekDetayPresenter = presenter
    }
}
