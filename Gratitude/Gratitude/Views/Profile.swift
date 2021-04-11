//
//  Profile.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var network = Networking()
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 246/255, blue: 225/255).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(self.network.user.realName).bold().padding([.leading, .trailing], 25).font(.largeTitle).padding(.top, 20)
                
                Text(String(self.network.user.following.count) + " Followers").padding([.leading, .trailing], 25).font(.title2).padding(.top, 10)
                
                
                Text("Posts").padding([.leading, .trailing], 25).font(.title).padding(.top, 20)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        
                        
                        ForEach(network.userPosts, id: \.self) {
                            post in
                            PostPreview(name: post.username, info: post.body, category: post.category, moodRating: post.userMood)
                        }
                        
                        Spacer()
                        
                    }.padding(.bottom, 50)
                }
            }
            
        }.onAppear {
            self.network.fetchUser(username: "justinyaodu")
            self.network.fetchUserFeed(username: "justinyaodu")
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
