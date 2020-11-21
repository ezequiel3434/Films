//
//  DetailViewModel.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 21/11/2020.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = ManagerConnections()
    private(set) weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        //TODO: Setear la vista en el router
    }
    
    func getMovieData(movieID: String) -> Observable<MovieDetail> {
        
    }
    
}
