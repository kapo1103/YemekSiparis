//
//  AnasayfaProtocols.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

// View - Presenter - Interactor

//Ana Protocoller
protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
}

protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
}

//Taşıyıcı protocoller
protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemeklerListesi:[Yemekler])
}

protocol PresenterToViewAnasayfaProtocol {
    func viewVeriGonder(yemeklerListesi:[Yemekler])
}

//Router Protocol
protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:Anasayfa)
}
