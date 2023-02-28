//
//  YemekSepetInteractor.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation
import Alamofire

class YemekSepetInteractor : PresenterToInteractorYemekSepetProtocol {
    
    var yemekSepetPresenter : InteractorToPresenterYemekSepetProtocol?

    func sepetiYukle(kullanici_adi: String) {
        
        let params : Parameters = ["kullanici_adi": kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let liste = cevap.sepet_yemekler {
                        self.yemekSepetPresenter?.presenteraVeriGonder(sepetListesi: liste)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func yemekSepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        
        let params : Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]

        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    DispatchQueue.main.async {
                        self.sepetiYukle(kullanici_adi: kullanici_adi)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
     
    
    func sepetSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params : Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]

        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    DispatchQueue.main.async {
                        self.sepetiYukle(kullanici_adi: kullanici_adi)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
