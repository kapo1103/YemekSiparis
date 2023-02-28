//
//  TableViewHucre.swift
//  YemekSiparis
//
//  Created by Ethem Fatih Hocaoğlu on 22.02.2023.
//

import UIKit
import Kingfisher

class TableViewHucre: UITableViewCell {

    @IBOutlet weak var labelYemekAdi: UILabel!
    @IBOutlet weak var labelYemekFiyati: UILabel!
    @IBOutlet weak var imageYemek: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
