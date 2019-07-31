//
//  MovieListController.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 19/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import UIKit

class MovieListController: UITableViewController {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var networkManager: Networkable!
    
    private var groupedArray: [(key: Int?, value: [Film])] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destinationController = segue.destination as? MovieDetailController, let film = sender as? Film {
            destinationController.filmDetail = film
        }
    }
    
    private func setupScreen() {
        getFilms()
        setupRefreshControl()
    }
    
    private func getFilms() {
        networkManager.getFilms { [weak self] films, errorMessage in
            guard let `self` = self else { return }
            
            self.refresher.endRefreshing()
            
            if let error = errorMessage {
                self.hideLoadingView(false, errorText: error)
            } else {
                self.groupedArray = Dictionary(grouping: films) { $0.year }.sorted(by: { $0.0 ?? 0 < $1.0 ?? 0})
                
                self.hideLoadingView(true)
            }
        }
    }
    
    private func hideLoadingView(_ condition: Bool, errorText: String? = nil) {
        guard let _ = errorLabel, let _ = activityIndicator else { return }
        
        errorLabel.isHidden = condition
        activityIndicator.stopAnimating()
        
        if condition {
            tableView.tableFooterView = nil
        } else {
            errorLabel.text = errorText
        }
        
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refresher
    }
    
    @objc private func reloadData() {
        getFilms()
    }
}

// MARK: UITableViewDataSource / UITableViewDelegate
extension MovieListController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedArray[section].value.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(groupedArray[section].key ?? 0)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmCell
        
        let item = groupedArray[indexPath.section].value[indexPath.row]
        
        cell.setupCell(with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let film = groupedArray[indexPath.section].value[indexPath.row]
        
        performSegue(withIdentifier: "toFilmDetails", sender: film)
    }
}
