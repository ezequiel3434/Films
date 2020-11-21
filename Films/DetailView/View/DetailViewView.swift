//
//  DetailViewView.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 21/11/2020.
//

import UIKit

class DetailViewView: UIViewController {

    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var descriptionMovie: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var originalTitle: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    
    var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }



}
