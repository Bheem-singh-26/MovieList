//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import UIKit

final class MovieListViewController: UIViewController {

    private let viewModel = MovieViewModel() // ViewModel for movie details
    
    // UI Components
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        bindViewModel()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let width = (view.frame.width-60)/2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width + 40)
        let nib = UINib(nibName: "MovieListCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "MovieListCell")
    }

    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        navigationItem.titleView = searchBar
    }

    private func bindViewModel() {
        viewModel.reloadMovies = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(with: error)
            }
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        viewModel.searchMovies(query: query)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailViewController()
        detailView.movieID = viewModel.movies[indexPath.row].imdbID
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
}
