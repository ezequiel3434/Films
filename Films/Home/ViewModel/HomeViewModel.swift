//
//  HomeViewModel.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 09/11/2020.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerConnections = ManagerConnections()
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        
        // binde router and view
        self.router?.setSourceView(view)
    }
    
    func getListMoviesData() -> Observable<[Movie]> {
        return managerConnections.getPopularMovies()
    }
    
}
