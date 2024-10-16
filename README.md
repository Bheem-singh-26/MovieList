# MovieList iOS Application

A simple movie listing app using **UIKit** and **MVVM architecture** with the following features:
- **Search for Movies**: Users can search for movies using the OMDb API.
- **Pagination**: Supports infinite scrolling with pagination.
- **Image Caching**: Movie posters are loaded and cached to improve performance.
- **Movie Details**: Users can view detailed information about a movie.
- **Reusable Network Layer**: The project uses a generic HTTP client to handle API requests and JSON decoding.

## Features

1. **Movie Search**
   - Users can enter a search term in the search bar to find movies using the OMDb API.
   - The movie list is displayed in a grid format (2-column layout) with the movie's poster and title.

2. **Pagination**
   - When the user scrolls to the bottom of the list, the app automatically loads the next page of results, providing an infinite scrolling experience.

3. **Image Caching**
   - Posters for movies are loaded asynchronously and cached using `NSCache`.
   - This improves the app's performance and prevents repeated network requests for the same image.

4. **Movie Details**
   - Users can tap on a movie in the list to view detailed information about it, including the poster, title, release date, director, and plot summary.

5. **Reusable HTTP Client**
   - The project features a reusable, generic network layer (`HttpClient`) to handle GET requests and JSON decoding. It ensures clean and maintainable networking code throughout the app.

## Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern, which separates the UI logic from the data-fetching logic. This ensures a clear separation of concerns and makes the code easier to maintain and test.

- **Model**: Represents the data (e.g., `Movie` and `MovieResponse` structs).
- **ViewModel**: Contains the logic to fetch movies, handle pagination, and manage UI states (e.g., showing errors, loading indicators).
- **View**: Manages the UI and user interaction (e.g., `MovieListViewController` and `MovieDetailViewController`).
- **HttpClient**: A reusable HTTP client to handle network requests and JSON decoding.

## Requirements

- **iOS 16.4+**
- **Xcode 14.3+**
- **Swift 5**

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Bheem-singh-26/MovieList.git


