//
//  DetailViewView.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 21/11/2020.
//

import UIKit
import RxSwift

class DetailView: UIViewController {

    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var descriptionMovie: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var originalTitle: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataAndShowDetailMovie()
        viewModel.bind(view: self, router: router)
    }
    
    func showMovieData(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.titleHeader.text = movie.title
            self.imageFilm.imageFromServerURL(urlString: Constants.URL.images+movie.posterPath, placeholderImage: UIImage(named: "claqueta")!)
            self.descriptionMovie.text = movie.overview
            self.originalTitle.text = movie.originalTitle
            self.releaseDate.text = movie.releaseDate
            self.voteAverage.text = String(movie.voteAverage)
        }
    }

    private func getDataAndShowDetailMovie() {
        guard let idMovie = movieID else { return }
        return viewModel.getMovieData(movieID: idMovie).subscribe (onNext: { (movie) in
            self.showMovieData(movie: movie)
        }, onError: { (error) in
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }, onCompleted: {
            
        }).disposed(by: disposeBag)

    }


}
