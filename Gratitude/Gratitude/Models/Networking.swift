//
//  Networking.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import Foundation

class Networking: ObservableObject {
    @Published var posts = [Post]()
    @Published var user:User = User(following: [], realName: "")
    @Published var userPosts = [Post]()
    
    func fetchFeed(username:String) {
        if let url = URL(string: "https://gratitude-310305.uc.r.appspot.com/api/feed/" + username) {
            let urlSession = URLSession(configuration: .default)
            let datatask = urlSession.dataTask(with: url) { (data, response, error) in
                if (error == nil){
                    let jsonDecoder = JSONDecoder()
                    if let checkedData = data {
                        do {
                            let result = try jsonDecoder.decode(Feed.self, from: checkedData)
                            DispatchQueue.main.async {
                                self.posts = result.posts
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            datatask.resume()
        }
    }
    
    func fetchUser(username:String) {
        if let url = URL(string: "https://gratitude-310305.uc.r.appspot.com/api/user/" + username) {
            let urlSession = URLSession(configuration: .default)
            let datatask = urlSession.dataTask(with: url) { (data, response, error) in
                if (error == nil){
                    let jsonDecoder = JSONDecoder()
                    if let checkedData = data {
                        do {
                            let result = try jsonDecoder.decode(User.self, from: checkedData)
                            DispatchQueue.main.async {
                                self.user = result
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            datatask.resume()
        }
    }
    
    func fetchUserFeed(username:String) {
        if let url = URL(string: "https://gratitude-310305.uc.r.appspot.com/api/post/" + username) {
            let urlSession = URLSession(configuration: .default)
            let datatask = urlSession.dataTask(with: url) { (data, response, error) in
                if (error == nil){
                    let jsonDecoder = JSONDecoder()
                    if let checkedData = data {
                        do {
                            let result = try jsonDecoder.decode(Feed.self, from: checkedData)
                            DispatchQueue.main.async {
                                self.userPosts = result.posts
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            datatask.resume()
        }
    }
    
    func postNewPost(post: Post, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let url = URL(string: "https://gratitude-310305.uc.r.appspot.com/api/post") {
            let jsonEncoder = JSONEncoder()
            do {
                let data = try jsonEncoder.encode(post)
                let urlSession = URLSession(configuration: .default)
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                let uploadTask = urlSession.uploadTask(with: urlRequest, from: data, completionHandler: completionHandler)
                uploadTask.resume()
            } catch {
                print(error)
            }
        }
    }
}
