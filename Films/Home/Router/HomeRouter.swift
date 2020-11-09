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
    
    
    func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    
}
