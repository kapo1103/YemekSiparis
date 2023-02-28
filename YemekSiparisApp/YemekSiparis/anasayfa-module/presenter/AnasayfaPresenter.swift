//
//  AnasayfaPresenter.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation

class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle() {
        anasayfaInteractor?.yemekleriYukle()
    }
    
    func ara(aramaKelimesi: String) {
        anasayfaInteractor?.ara(aramaKelimesi: aramaKelimesi)
    }
}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemeklerListesi: [Yemekler]) {
        anasayfaView?.viewVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
