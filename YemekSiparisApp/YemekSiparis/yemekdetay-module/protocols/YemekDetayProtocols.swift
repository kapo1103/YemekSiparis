//
//  YemekDetayProtocols.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

protocol ViewToPresenterYemekDetayProtocol {
    var yemekDetayInteractor: PresenterToInteractorYemekDetayProtocol? {get set}
    var yemekDetayView : PresenterToViewYemekDetayProtocol? {get set}
    
    func yemekSepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String)
    
    func sepetiYukle(kullanici_adi: String)

    func sepetSil(sepet_yemek_id: Int, kullanici_adi: String)

}

protocol PresenterToInteractorYemekDetayProtocol {
    var yemekDetayPresenter: InteractorToPresenterYemekDetayProtocol? {get set
        
    }
    func yemekSepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String)
    
    func sepetiYukle(kullanici_adi: String)

    func sepetSil(sepet_yemek_id: Int, kullanici_adi: String)


}

protocol InteractorToPresenterYemekDetayProtocol {
    func presenteraVeriGonder(yemekListesi:Array<Sepet>)
}

protocol PresenterToViewYemekDetayProtocol {
    func vieweVeriGonder(yemekListesi:Array<Sepet>)

}

protocol PresenterToRouterYemekDetayProtocol {
    static func createModule(ref: YemekDetay)
}
