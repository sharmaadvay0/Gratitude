//
//  ContentView.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/9/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

            TabView {
                Home()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
            }.accentColor(Color(red: 242/255, green: 163/255, blue: 25/255))
            .onAppear {
                UITabBar.appearance().barTintColor = .white
            }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
