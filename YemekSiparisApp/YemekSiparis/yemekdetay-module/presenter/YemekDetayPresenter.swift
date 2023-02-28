//
//  YemekDetayPresenter.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

class YemekDetayPresenter : ViewToPresenterYemekDetayProtocol {
    var yemekDetayInteractor: PresenterToInteractorYemekDetayProtocol?
    var yemekDetayView: PresenterToViewYemekDetayProtocol?
    
    func sepetiYukle(kullanici_adi: String) {
        yemekDetayInteractor?.sepetiYukle(kullanici_adi: kullanici_adi)
    }

    func sepetSil(sepet_yemek_id: Int, kullanici_adi: String) {
        yemekDetayInteractor?.sepetSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func yemekSepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        
        yemekDetayInteractor?.yemekSepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    
    
}

extension YemekDetayPresenter : InteractorToPresenterYemekDetayProtocol {
    func presenteraVeriGonder(yemekListesi: Array<Sepet>) {
        yemekDetayView?.vieweVeriGonder(yemekListesi: yemekListesi)
    }
}
