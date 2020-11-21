//
//  HomeView.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 09/11/2020.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar una pelicula"
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "The movies App"
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
        manageSearchBarController()
        
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
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { (result) in
                self.filteredMovies = self.movies.filter({ (movie) in
                    
                    self.reloadTableView()
                    return movie.title.contains(result)
                })
                
            })
            .disposed(by: disposeBag)
        
    }
}


extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        } else {
            return movies.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomMovieCell.self)) as! CustomMovieCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.imageMovie.imageFromServerURL(urlString: Constants.URL.images+self.filteredMovies[indexPath.row].image, placeholderImage: UIImage(named: "claqueta")!)
            cell.titleMovie.text = filteredMovies[indexPath.row].title
            cell.descriptionMovie.text = filteredMovies[indexPath.row].sinposis
        } else {
            cell.imageMovie.imageFromServerURL(urlString: Constants.URL.images+self.movies[indexPath.row].image, placeholderImage: UIImage(named: "claqueta")!)
            cell.titleMovie.text = movies[indexPath.row].title
            cell.descriptionMovie.text = movies[indexPath.row].sinposis
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.makeDetailView(movieID: String(self.filteredMovies[indexPath.row].movieID))
        } else {
            viewModel.makeDetailView(movieID: String(self.movies[indexPath.row].movieID))
            
        }
    }
    
}


extension HomeView: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
