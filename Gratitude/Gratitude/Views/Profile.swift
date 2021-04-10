//
//  Profile.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 246/255, blue: 225/255).ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    
                    HStack(alignment: .top) {
                        
                        Text("Your Profile").bold().font(.largeTitle).padding(.leading, 25).padding(.top, 10)
                        
                        Spacer()
                        
                    }.padding(.trailing, 25)
                    
                    Text("Name").bold().padding([.leading, .trailing], 25).font(.title).padding(.top, 20)
                    
                    Text("10 Following").padding([.leading, .trailing], 25).font(.title2).padding(.top, 10)
                    
                    
                    Text("Posts").padding([.leading, .trailing], 25).font(.title).padding(.top, 20)
                    
                    ForEach(0..<10) {
                        number in
                        PostPreview(name: "Test Name", info: "Test Info")
                    }
                    
                    Spacer()
                    
                }.padding(.bottom, 50)
            }
            
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
