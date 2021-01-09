import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation

struct Movie: Codable {
    let title: String
}

Lambda.run { (context, payload: Movie, completion: @escaping (Result<[Movie], Error>) -> Void) in
    
    var movies = [
        Movie(title: "Greenland"),
        Movie(title: "Hunter Hunter")
    ]
    
    movies.append(payload)
    
    completion(.success(movies))
}
