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
                Activity()
                    .tabItem {
                        Label("Activity", systemImage: "chart.bar.fill")
                    }
            }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
