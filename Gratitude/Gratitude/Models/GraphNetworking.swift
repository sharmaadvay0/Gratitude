//
//  GraphNetworking.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import Foundation

class GraphNetworking: ObservableObject {
    
    @Published var moodArray = [Double]()
    @Published var category:[(String, Int)] = []
    
    func fetchGraphData(username:String) {
        if let url = URL(string: "https://gratitude-310305.uc.r.appspot.com/api/post/" + username) {
            let urlSession = URLSession(configuration: .default)
            let datatask = urlSession.dataTask(with: url) { (data, response, error) in
                if (error == nil){
                    let jsonDecoder = JSONDecoder()
                    if let checkedData = data {
                        do {
                            let result = try jsonDecoder.decode(Feed.self, from: checkedData)
                            DispatchQueue.main.async {
                                let posts:[Post] = result.posts
                                var mood:[Double] = []
                                var activities = 0
                                var art = 0
                                var career = 0
                                var community = 0
                                var emotions = 0
                                var family = 0
                                var food = 0
                                var health = 0
                                var nature = 0
                                var necessities = 0
                                var technology = 0
                                var other = 0
                                for post in posts {
                                    let averagedMood = ((post.sentimentMood + post.userMood) / 2) * 100
                                    mood.append(averagedMood)
                                    
                                    if post.category == "activities" {
                                        activities+=1
                                    }
                                    if post.category == "art" {
                                        art+=1
                                    }
                                    if post.category == "career" {
                                        career+=1
                                    }
                                    if post.category == "community" {
                                        community+=1
                                    }
                                    if post.category == "emotions" {
                                        emotions+=1
                                    }
                                    if post.category == "family" {
                                        family+=1
                                    }
                                    if post.category == "food" {
                                        food+=1
                                    }
                                    if post.category == "health" {
                                        health+=1
                                    }
                                    if post.category == "nature" {
                                        nature+=1
                                    }
                                    if post.category == "necessities" {
                                        necessities+=1
                                    }
                                    if post.category == "technology" {
                                        technology+=1
                                    }
                                    if post.category == "other" {
                                        other+=1
                                    }
                                }
                                self.category = [("Activities", activities),("Art", art),("Career", career),("Community", community),("Emotions & Faith", emotions),("Family & Friends", family),("Food & Drink", food),("Health & Fitness", health),("Nature & Weather", nature),("Necessities", necessities),("Technology", technology),("Other", other)]
                                self.moodArray = mood
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
}
