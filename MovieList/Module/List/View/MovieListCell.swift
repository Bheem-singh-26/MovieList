//
//  MovieListCell.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import UIKit

class MovieListCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        titleLabel.numberOfLines = 2
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        if let url = URL(string: movie.poster) {
            // Fetch and set image (bonus: add caching)
        }
    }

}
