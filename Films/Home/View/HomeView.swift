//
//  HomeView.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 09/11/2020.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)

    }


}


extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        return cell
    }
    
     
}
