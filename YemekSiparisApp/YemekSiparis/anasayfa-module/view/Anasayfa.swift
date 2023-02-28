//
//  ViewController.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 19.02.2023.
//

import UIKit

class Anasayfa: UIViewController {
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var layer: UIView!
    
    var yemeklerListe = [Yemekler]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        
        AnasayfaRouter.createModule(ref: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let yemek = sender as? Yemekler {
                let gidilecekVC = segue.destination as! YemekDetay
                gidilecekVC.yemek = yemek
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle()
        self.tabBarController?.navigationItem.title = "Ürünler"
    }
    

}

extension Anasayfa : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        yemeklerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // yemek adı ve fiyatı getirme
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yemeklerHucre") as! TableViewHucre
        let yemek = yemeklerListe[indexPath.row]
        hucre.labelYemekAdi.text = yemek.yemek_adi
        hucre.labelYemekFiyati.text = "\(yemek.yemek_fiyat!) ₺"
        
        //yemek resim getirme
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                hucre.imageYemek.kf.setImage(with: url)
            }
        }

        return hucre
    }
    //detaya veri gönderme
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = yemeklerListe[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension Anasayfa : PresenterToViewAnasayfaProtocol {
    func viewVeriGonder(yemeklerListesi: [Yemekler]) {
        self.yemeklerListe = yemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerTableView.reloadData()
        }
    }
}

extension Anasayfa : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        anasayfaPresenterNesnesi?.ara(aramaKelimesi: searchText)
    }
}
