//
//  YemekSepet.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 19.02.2023.
//

import UIKit

class YemekSepet: UIViewController {

    @IBOutlet weak var labelSepetTutar: UILabel!
    @IBOutlet weak var yemekSepetTableView: UITableView!
    @IBOutlet weak var buttonSiparisTamamla: UIButton!
    
    var sepetList = [Sepet]()
    var izinKontrol = false

    var yemekSepetPresenterNesnesi : ViewToPresenterYemekSepetProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yemekSepetTableView.delegate = self
        yemekSepetTableView.dataSource = self
        UNUserNotificationCenter.current().delegate = self
        
        YemekSepetRouter.createModule(ref: self)
        

        
        //bildirim
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge],completionHandler: { granted,error in
            self.izinKontrol = granted
            
            if granted {
                print("izin verildi")
            }else{
                print("izin verilmedi")
            }
        } )


    }
    override func viewWillAppear(_ animated: Bool) {
        yemekSepetPresenterNesnesi?.sepetiYukle(kullanici_adi: "a")
        self.yemekSepetTableView.reloadData()
        
        
        self.tabBarController?.navigationItem.title = "Sepetim"

    }
    func bildirimIzin() {
        if izinKontrol {
            let icerik = UNMutableNotificationContent()
            icerik.title = "Siparişin Onaylandı."
            icerik.subtitle = "Afiyet Olsun."
            //icerik.body = "mesaj"
            icerik.badge = 1
            icerik.sound = UNNotificationSound.default
            
            //arkaplan çalışma
            let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let bilirimIstegi = UNNotificationRequest(identifier: "sepet", content: icerik, trigger: tetikleme)
            UNUserNotificationCenter.current().add(bilirimIstegi)
        }
    }
    
    func toplamFiyat() {
        var toplam = 0
        
        for y in sepetList {
                toplam = toplam + Int(y.yemek_fiyat!)!
                labelSepetTutar.text = String(toplam)
        }
    }
    
    @IBAction func buttonSiparisTamamla(_ sender: Any) {
        
        if sepetList.isEmpty {
            let alertController = UIAlertController(title: "Uyarı", message: "Lütfen sepete ürün ekleyiniz.", preferredStyle: .alert)
            
            let tamamAction = UIAlertAction(title: "Tamam", style: .destructive) 
            alertController.addAction(tamamAction)
            self.present(alertController,animated: true)
        }else{
            bildirimIzin()
            performSegue(withIdentifier: "toSonuc", sender: nil)
        }
    }
}

extension YemekSepet : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yemekSepetiHucre") as! TableViewSepetHucre
        
        let sepet = sepetList[indexPath.row]
    
            
            hucre.labelYemekAdi.text = sepet.yemek_adi
            hucre.labelYemekAdet.text = sepet.yemek_siparis_adet
            hucre.labelYemekFiyati.text = sepet.yemek_fiyat
    
        
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(sepet.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    hucre.imageSepet.kf.setImage(with: url)
                }
            }
        
        return hucre
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return sepetList.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silmeAction = UIContextualAction(style: .destructive, title: "Silme") { (contextualAction,view,bool) in
            let sepet = self.sepetList[indexPath.row]
            let alert = UIAlertController(title: "Sepetten kaldır", message: "\(sepet.yemek_adi!) sepetten kaldırısın mı?", preferredStyle: .alert)
            let hayirAction = UIAlertAction(title: "Hayır", style: .cancel)
            alert.addAction(hayirAction)

            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.sepetList.remove(at: indexPath.row)
                self.yemekSepetPresenterNesnesi?.sepetSil(sepet_yemek_id: Int(sepet.sepet_yemek_id!)!, kullanici_adi: sepet.kullanici_adi!)
                DispatchQueue.main.async {
                    self.yemekSepetTableView.reloadData()
                    self.labelSepetTutar.text = "0"
                    self.toplamFiyat()

                }
            }
            
            alert.addAction(evetAction)
            self.present(alert,animated: true)

        }
        return UISwipeActionsConfiguration(actions: [silmeAction])

    }
}

extension YemekSepet : PresenterToViewYemekSepetProtocol {
    func vieweVeriGonder(sepetListesi: [Sepet]) {
        self.sepetList = sepetListesi
        DispatchQueue.main.async {
            self.yemekSepetTableView.reloadData()
            
            self.toplamFiyat()
        }
    }

}

extension YemekSepet : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("bildirim tıklandı")
        let app = UIApplication.shared

        app.applicationIconBadgeNumber = 0
        completionHandler()
    }
}


