//
//  YemekDetay.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 19.02.2023.
//

import UIKit
import Lottie

class YemekDetay: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    @IBOutlet weak var imageYemekDetay: UIImageView!
    @IBOutlet weak var labelYemekFiyatiDetay: UILabel!
    @IBOutlet weak var labelYemekAdiDetay: UILabel!
    @IBOutlet weak var yemekStepper: UIStepper!
    @IBOutlet weak var labelYemekAdet: UILabel!
    

    var yemek : Yemekler?
    var sepet : Sepet?
    var adet : Int?
    var sepetListe = [Sepet]()

    var yemekDetayPresenterNesnesi : ViewToPresenterYemekDetayProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        YemekDetayRouter.createModule(ref: self)
        
        labelYemekAdet.text =  String(Int(yemekStepper.value))
        

        if let y = yemek {
            labelYemekAdiDetay.text = yemek!.yemek_adi
            labelYemekFiyatiDetay.text = yemek!.yemek_fiyat!
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.imageYemekDetay.kf.setImage(with: url)
                }
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        yemekDetayPresenterNesnesi?.sepetiYukle(kullanici_adi: "a")
        
    }
    
    func LottieAnimation() {
        
        animationView = .init(name: "sepet")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.loopMode = .playOnce
        animationView!.play(completion: { ( finished) in
            if finished { //animasyon bitince durdurma
                self.animationView.isHidden = true
                self.dismiss(animated: true) // animasyon bitince ekranı kapatma
            }
        })
        
    }
    @IBAction func actionStepper(_ sender: UIStepper) {
        labelYemekAdet.text = String(Int(yemekStepper.value))

    }
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {

        LottieAnimation()
        
        //dismiss(animated: true) // butona basınca sayfa kapatma
        yemekDetayPresenterNesnesi?.sepetiYukle(kullanici_adi: "a")
        
        if let kontrol = sepetListe.first (where: {$0.yemek_adi == yemek?.yemek_adi}) {
            //sepette aynı ürün varsa
            print("if")
            yemekDetayPresenterNesnesi?.sepetSil(sepet_yemek_id: Int(kontrol.sepet_yemek_id!)!, kullanici_adi: "a")

            //let adet = Int(labelYemekAdet.text!)
            let adet = Int(yemekStepper.value)
            let yeniAdet = Int(kontrol.yemek_siparis_adet!)!
            let toplamAdet = adet + yeniAdet

            let fiyat = Int(yemek!.yemek_fiyat!)! * adet
            let yeniFiyat = Int(kontrol.yemek_fiyat!)!
            let toplamFiyat = fiyat + yeniFiyat
            
            
            if let y = yemek {
                yemekDetayPresenterNesnesi?.yemekSepeteEkle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: toplamFiyat, yemek_siparis_adet: toplamAdet, kullanici_adi: "a")
            }

        }
        else { //Sepette aynı urun yoksa çalış
            if let y = yemek {
                let adet = Int(labelYemekAdet.text!)
                let fiyat = Int(y.yemek_fiyat!)! * adet!
                print("else")
                yemekDetayPresenterNesnesi?.yemekSepeteEkle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: fiyat, yemek_siparis_adet: adet!, kullanici_adi: "a")

                labelYemekAdet.text = String(adet!)
            
            }
        }
    }
    
}


extension YemekDetay : PresenterToViewYemekDetayProtocol {
    func vieweVeriGonder(yemekListesi: Array<Sepet>) {
        self.sepetListe = yemekListesi
    }
}


