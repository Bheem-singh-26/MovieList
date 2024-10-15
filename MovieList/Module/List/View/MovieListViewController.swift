import UIKit

final class MovieListViewController: UIViewController {

    private let viewModel = MovieListViewModel() // ViewModel for movie details

    // UI Components
    @IBOutlet weak var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        setupActivityIndicator()
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

    private func setupActivityIndicator() {
        // Initialize and configure activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true  // Automatically hides when it's stopped
        view.addSubview(activityIndicator)
    }

    private func bindViewModel() {
        viewModel.reloadMovies = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating() // Stop and hide the indicator
                self?.collectionView.reloadData()
            }
        }

        viewModel.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating() // Stop the indicator even on error
                self?.showAlert(with: error)
            }
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text else { return }
        
        // Start showing the loading indicator
        activityIndicator.startAnimating()

        // Trigger the search in the ViewModel
        viewModel.searchMovies(query: query)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
    
    // This function detects when the user scrolls near the bottom of the collection view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Trigger loading more data when the user scrolls near the bottom
        if offsetY > contentHeight - height * 2 {
            viewModel.loadMoreMovies()  // Fetch more movies
        }
    }
}
