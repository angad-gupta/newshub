import Foundation
import UIKit

final class APICaller {
    static let shared = APICaller();
    var category = "top-headlines";
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=27f98dc385fc449480e9993fa2990c3c")
    }
    
    private init() {
        
    }
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getCategoryNews(category: String?, completion: @escaping (Result<[Article], Error>) -> Void){
//        guard let url = Constants.topHeadlinesURL else{
//            return
//        }
        var url = Constants.topHeadlinesURL
        if category != nil{
            url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category="+category!+"&apiKey=27f98dc385fc449480e9993fa2990c3c")
        }
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Codable{
    let name: String
}
