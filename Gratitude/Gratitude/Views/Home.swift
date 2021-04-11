//
//  Home.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/9/21.
//

import SwiftUI

struct Home: View {
    
    
    @State var makePost = false
    @ObservedObject var network = Networking()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 255/255, green: 246/255, blue: 225/255).ignoresSafeArea()
                VStack {
                    
                    HStack(alignment: .top) {
                        
                        Header(name: network.user.realName)
                        
                        Spacer()
                        
                        Button(action: {
                            makePost = true
                        }, label: {
                            Image(systemName: "plus").resizable()
                                .frame(width: 20, height: 20, alignment: .center).foregroundColor(.black).padding(.top, 10)
                            
                        })
                    }.padding(.trailing, 25)
                    
                    ListOfPosts(posts: network.posts)
                    
                    Spacer()
                    
                }
            }.onAppear {
                self.network.fetchFeed(username: "justinyaodu")
                self.network.fetchUser(username: "justinyaodu")
            }
            
            
        }.sheet(isPresented: $makePost, content: {
            CreatePost(isShown: $makePost)
        }).padding(.top, -90)
        
        
    }
}

struct PostPreview: View {
    let name: String?
    let info: String?
    let category: String?
    let moodRating: Double?
    
    var body: some View {
        
        NavigationLink(
            destination: PostDetails(name: name ?? "Name", info: info ?? "Post Info", category: category ?? "other", moodRating: moodRating ?? 5.0),
            label: {
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(name ?? "Name Here").padding(.bottom, 10).font(.system(size: 20, weight: .bold)).foregroundColor(.init(red: 130/255, green: 130/255, blue: 130/255))
                            Text(info ?? "Info Here").foregroundColor(.black)
                        }.padding()
                        Spacer()
                    }
                }
                .background (
                    RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.white).shadow(radius: 3)
                ).padding([.trailing,.leading], 25)
                .padding(.top, 10)
            })
        
        
    }
}

struct ListOfPosts: View {
    var posts: [Post]
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(posts, id: \.self) {
                    post in
                    PostPreview(name: post.username, info: post.body, category: post.category, moodRating: post.userMood)
                }
            }.padding(.bottom, 100)
        }
    }
}

struct Header: View {
    var name:String
    var body: some View {
        VStack(alignment: .leading) {
            
            DateText()
            
            Text("Welcome " + name + "!").font(.system(size: 24)).fontWeight(.bold)
            
        }.padding(.leading, 25).padding(.top, 10)
    }
}

struct DateText: View {
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        return formatter.string(from: date)
    }
    var body: some View {
        Text(self.getCurrentDate() + "th")
            .padding(.bottom, 5)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.init(red: 130/255, green: 130/255, blue: 130/255))
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
