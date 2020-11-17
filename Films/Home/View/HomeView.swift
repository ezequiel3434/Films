//
//  HomeView.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 09/11/2020.
//

import UIKit
import RxSwift

class HomeView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
        
    }
    
    private func configureTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }

    private func getData(){
        return viewModel.getListMoviesData()
        // manejar concurrencia o hilos de RxSwift
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        // suscribirme a el observable
            .subscribe { (movies) in
                self.movies = movies
                self.reloadTableView()
            } onError: { (error) in
                print(error.localizedDescription)
            } onCompleted: {
            }.disposed(by: disposeBag)

        // Dar por completado la secuencia de RxSwift
        
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
        }
    }
}


extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomMovieCell.self)) as! CustomMovieCell
        cell.titleMovie.text = movies[indexPath.row].title
        cell.descriptionMovie.text = movies[indexPath.row].sinposis
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
     
}
