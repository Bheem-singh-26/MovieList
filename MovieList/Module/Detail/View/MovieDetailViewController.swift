//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    var movieID: String?  // The movie ID to fetch details for
    private let viewModel = MovieDetailViewModel()  // ViewModel for movie details

    // UI Components
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let directorLabel = UILabel()
    private let plotLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchMovieDetails()
    }
    
    private func setupUI() {
        // Basic UI setup for the labels and image view
        view.backgroundColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        releaseDateLabel.font = UIFont.systemFont(ofSize: 18)
        directorLabel.font = UIFont.systemFont(ofSize: 18)
        plotLabel.font = UIFont.systemFont(ofSize: 16)
        plotLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [posterImageView, titleLabel, releaseDateLabel, directorLabel, plotLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Add constraints
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            posterImageView.widthAnchor.constraint(equalToConstant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func fetchMovieDetails() {
        guard let movieID = movieID else { return }
        
        viewModel.fetchMovieDetails(movieID: movieID) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.updateUI(with: movie)
                }
            case .failure(let error):
                print("Error fetching movie details: \(error)")
                DispatchQueue.main.async {
                    self?.showAlert(with: error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI(with movie: MovieDetail) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Released: \(movie.releaseDate)"
        directorLabel.text = "Director: \(movie.director)"
        plotLabel.text = movie.plot
        
        if let posterURL = URL(string: movie.poster) {
            // Fetch and set the image (consider using a simple image caching mechanism)
            downloadImage(from: posterURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
        }
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
