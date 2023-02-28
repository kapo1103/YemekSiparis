//
//  YemekSepetProtocols.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

protocol ViewToPresenterYemekSepetProtocol {
    var yemekSepetInteractor : PresenterToInteractorYemekSepetProtocol? {get set}
    var yemekSepetView : PresenterToViewYemekSepetProtocol? {get set}
    
    func sepetiYukle(kullanici_adi: String)
   
    func sepetSil(sepet_yemek_id: Int, kullanici_adi: String)
    
    func yemekSepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String)
}

protocol PresenterToInteractorYemekSepetProtocol {
    var yemekSepetPresenter : InteractorToPresenterYemekSepetProtocol? {get set}
    
    func sepetiYukle(kullanici_adi: String)
  
    func sepetSil(sepet_yemek_id: Int, kullanici_adi: String)
    
    func yemekSepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String)
}

protocol InteractorToPresenterYemekSepetProtocol {
    func presenteraVeriGonder(sepetListesi: [Sepet])
}

protocol PresenterToViewYemekSepetProtocol {
    func vieweVeriGonder(sepetListesi: [Sepet])
}

protocol PresenterToRouterYemekSepetprotocol {
    static func createModule(ref: YemekSepet)
}

