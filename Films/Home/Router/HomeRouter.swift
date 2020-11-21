//
//  HomeRouter.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 09/11/2020.
//
/// This class will create my home object
import Foundation
import UIKit

class HomeRouter {
    var viewCOntgroller: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    
    func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Unknown error") }
        self.sourceView = view
    }
    
    func navigateToDetailView(movieID: String) {
        let detailView = DetailRouter(movieID: movieID).viewCOntgroller
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
