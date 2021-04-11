//
//  PostDetails.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import SwiftUI

struct PostDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var networking = Networking()
    
    var name:String
    var info:String
    var category: String
    var moodRating: Double
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            HStack {
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                    Image(systemName: "chevron.backward").resizable().foregroundColor(.black).frame(width:15, height: 25)
                })
                
                Text(self.networking.user.realName).fontWeight(.bold).font(.largeTitle).padding(.leading, 10)
                Spacer()
            }.padding(.leading, 25).padding(.top, 10)
            Text(name).padding([.leading,.trailing], 25).padding(.top, 10).font(.custom("details", size: 20))
            Text(info).padding([.leading,.trailing], 25).padding(.top, 10).font(.custom("details", size: 20))
            VStack(alignment: .leading) {
                HStack {
                    Text("Category").fontWeight(.bold).font(.title)
                    CategoryButton(selected: true, text: Categories.categoryTitles[category] ?? category)
                    Spacer()
                }
                
                Text("Mood rating: " + String(moodRating * 100) + "%").fontWeight(.bold).font(.title).padding(.top, 10)
            }.padding()
            Spacer()
        }.onAppear {
            var username = name
            username.remove(at: username.startIndex)
            self.networking.fetchUser(username: username)
        }
        
    }
}

struct PostDetails_Previews: PreviewProvider {
    static var previews: some View {
        PostDetails(name: "Name", info: "Post Info", category: "technology", moodRating: 4.5)
    }
}
