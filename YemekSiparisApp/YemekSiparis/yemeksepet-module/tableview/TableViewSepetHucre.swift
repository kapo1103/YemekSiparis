//
//  TableViewSepetHucre.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 23.02.2023.
//

import UIKit

class TableViewSepetHucre: UITableViewCell {

    @IBOutlet weak var labelYemekFiyati: UILabel!
    
    @IBOutlet weak var labelYemekAdet: UILabel!
    @IBOutlet weak var labelYemekAdi: UILabel!
    @IBOutlet weak var imageSepet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

    
}
