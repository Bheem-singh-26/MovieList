//
//  MovieListCell.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import UIKit

final class MovieListCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialize the view
        setupViews()
    }

    private func setupViews() {
        // Customize the cell to look like a card view
        contentView.layer.cornerRadius = 10  // Rounded corners
        contentView.layer.borderWidth = 1.0  // Optional border (thin)
        contentView.layer.borderColor = UIColor.lightGray.cgColor  // Light border color
        contentView.layer.masksToBounds = true

        // Add shadow to the cell to make it look like a floating card
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)  // Slight shadow for depth
        layer.shadowRadius = 4
        layer.masksToBounds = false

        // Configure imageView
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 10  // Image also gets rounded corners
        imageView.layer.masksToBounds = true

        // Configure titleLabel
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        if let url = URL(string: movie.poster) {
            // Fetch and set image (bonus: add caching)
        }
    }
}
