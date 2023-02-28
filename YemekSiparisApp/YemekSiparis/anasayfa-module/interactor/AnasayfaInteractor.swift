//
//  AnasayfaInteractor.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 20.02.2023.
//

import Foundation
import Alamofire

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
        
    func yemekleriYukle() {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler {
                        self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
         
    
    func ara(aramaKelimesi: String) {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler {
                        var aramaYemekListe = [Yemekler]()
                        if aramaKelimesi != "" {
                            for yemek in liste {
                                if yemek.yemek_adi!.lowercased().contains(aramaKelimesi.lowercased()) {
                                    aramaYemekListe.append(yemek)
                                }
                            }
                            print("bbb")
                            self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: aramaYemekListe)

                            
                        } else {
                            self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                                print("aaaa")
                        }
                        
                    }
                    
                    }catch {
                        print(error.localizedDescription)
                    
                }
            }
            
        }
    }
}


