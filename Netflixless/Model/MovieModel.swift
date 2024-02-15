import Foundation

class MovieModel: ObservableObject {
    @Published var movie: Movie = Movie(
        adult: false,
        backdropPath: nil,
        id: 123,
        title: nil,
        originalLanguage: .en,
        originalTitle: nil,
        overview: "This is an example movie overview.",
        posterPath: "/2RcBuU8cdxFxCJibbiYCGNLApfz.jpg",
        mediaType: .movie,
        genreIDS: [1, 2, 3],
        popularity: 7.5,
        releaseDate: "2022-01-01",
        video: true,
        voteAverage: 8.0,
        voteCount: 100,
        name: nil,
        originalName: nil,
        firstAirDate: nil,
        originCountry: nil,
        belongsToCollection: nil,
        budget: nil,
        genres: nil,
        homepage: nil,
        imdbID: nil,
        productionCompanies: nil,
        productionCountries: nil,
        revenue: nil,
        runtime: nil,
        spokenLanguages: nil,
        status: nil,
        tagline: nil,
        credits: nil,
        hasCollection: false
    )
    @Published var movies: [Movie] = []
    @Published var trendingMovies: Trendings = Trendings(page: 0, results: [], totalPages: 0, totalResults: 0)
    @Published var popularMovies: Trendings = Trendings(page: 0, results: [], totalPages: 0, totalResults: 0)
    @Published var upcomingMovies: UpcomingMovies = UpcomingMovies(dates: Dates(maximum: "", minimum: ""), page: 1, results: [], totalPages: 1, totalResults: 0)
    @Published var currentlyPlayingMovies: UpcomingMovies = UpcomingMovies(dates: Dates(maximum: "", minimum: ""), page: 1, results: [], totalPages: 1, totalResults: 0)
    @Published var collection: MovieCollection = MovieCollection(id: 0, name: nil, overview: nil, posterPath: nil, backdropPath: nil, parts: [])
    
    private var apiKey: String {
        guard let apiKey = ProcessInfo.processInfo.environment["MOVIEDB_API_KEY"] else {
            fatalError("API key not set. Please set the MOVIEDB_API_KEY environment variable.")
        }
        return apiKey
    }
    
    private var trendingUrl: URL {
        let urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    private var upcomingUrl: URL {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    private var popularUrl: URL {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    private var currentlyPlayingUrl: URL {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    func convertRuntimeInHour(runtime: Int) -> String {
        let heures = abs(runtime)

        let heuresPart = heures / 60
        let minutesPart = heures % 60

        let heuresString = heuresPart > 0 ? "\(heuresPart)h" : ""
        let minutesString = minutesPart > 0 ? "\(minutesPart)min" : ""

        return heuresString + minutesString
    }
    
    func setMediaType(to type: String, for shows: inout [Movie]) {
        for index in shows.indices {
            shows[index].mediaType = MediaType(rawValue: type)
        }
    }
    
    func setMediaTypeForMovies() {
        setMediaType(to: "movie", for: &upcomingMovies.results)
        setMediaType(to: "movie", for: &popularMovies.results)
        setMediaType(to: "movie", for: &currentlyPlayingMovies.results)
        setMediaType(to: "movie", for: &trendingMovies.results)
    }
    
    
    
    func fetchTrendingMovies() {
        let request = URLSession.shared.dataTask(with: trendingUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let trending = try JSONDecoder().decode(Trendings.self, from: data)
                DispatchQueue.main.async {
                    self?.movies = trending.results
                    self?.trendingMovies = trending
                    
                    self?.setMediaTypeForMovies()
                }
            } catch {
                print("error request 1")
            }
        }
        request.resume()
    }

    func fetchUpcomingMovies() {
        let request = URLSession.shared.dataTask(with: upcomingUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UpcomingMovies.self, from: data)
                DispatchQueue.main.async {
                    
                    self?.movies = result.results
                    self?.upcomingMovies = result
                    
                    self?.setMediaTypeForMovies()
                }
            } catch {
                print("error request 2 : \(error)")
            }
        }
        request.resume()
    }

    func fetchPopularMovies() {
        let request = URLSession.shared.dataTask(with: popularUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let popular = try JSONDecoder().decode(Trendings.self, from: data)
                DispatchQueue.main.async {
                    
                    self?.movies = popular.results
                    self?.popularMovies = popular
                    
                    self?.setMediaTypeForMovies()
                }
            } catch {
                print("error request 1")
            }
        }
        request.resume()
    }

    func fetchCurrentlyPlayingMovies() {
        let request = URLSession.shared.dataTask(with: currentlyPlayingUrl) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let currentlyPlaying = try JSONDecoder().decode(UpcomingMovies.self, from: data)
                DispatchQueue.main.async {
                    
                    self?.movies = currentlyPlaying.results
                    self?.currentlyPlayingMovies = currentlyPlaying
                    
                    self?.setMediaTypeForMovies()
                }
            } catch {
                print("error request 1")
            }
        }
        request.resume()
    }

    
    func createMovieDetailsByIdUrl(movieId: Int) -> URL {
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&append_to_response=credits"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    func fetchMovieDetailsById(movieId: Int) {
        let request = URLSession.shared.dataTask(with: createMovieDetailsByIdUrl(movieId: movieId)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    self?.movie = movie
                    if (self?.movie.belongsToCollection?.id != 0) {
                        self?.movie.hasCollection = true
                    }else {
                        self?.movie.hasCollection = false
                    }
                }
            } catch {
                print("error request movie \(error)")
            }
        }
        request.resume()
    }
    
    func createCollectionUrl(collectionId: Int) -> URL {
        let urlString = "https://api.themoviedb.org/3/collection/\(collectionId)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    func fetchMovieCollectionById(collectionId: Int) {
        let request = URLSession.shared.dataTask(with: createCollectionUrl(collectionId: collectionId)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let collection = try JSONDecoder().decode(MovieCollection.self, from: data)
                DispatchQueue.main.async {
                    self?.collection = collection
                }
            } catch {
                print("error request movie \(error)")
            }
            
        }
        
        request.resume()
    }
    
    func getDirector(Crew:[Cast]) -> Cast? {
        for crewMember in Crew {
            if (crewMember.knownForDepartment == .writing && crewMember.job == "director") {
                return crewMember
            }
        }
        return nil
    }
}

