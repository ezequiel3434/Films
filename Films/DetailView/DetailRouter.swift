//
//  DetailRouter.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 21/11/2020.
//

import UIKit


class DetailRouter {
    var viewCOntgroller: UIViewController {
        return createViewController()
    }
    
    var movieID: String?
    private var sourceView: UIViewController?
    
    init(movieID: String? = "") {
        self.movieID = movieID
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Unknown error") }
        self.sourceView = view
    }
    
    func createViewController() -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        return view
    }
    
}
