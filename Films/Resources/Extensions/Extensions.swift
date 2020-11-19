//
//  Extensions.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 18/11/2020.
//

import UIKit

extension UIImageView {
    
    func imageFromServerURL(urlString: String, placeholderImage: UIImage) {
        if self.image == nil {
            self.image = placeholderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
    
    
}

