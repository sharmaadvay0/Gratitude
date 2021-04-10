//
//  Activity.swift
//  Gratitude
//
//  Created by Bill Wu on 4/10/21.
//

import SwiftUI

struct Activity: View {
    var body: some View {
        ZStack {
            Color(red: 255 / 255, green: 246 / 255, blue: 225 / 255)
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    Text("Make a post")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top, 10)
                }
                .padding([.top, .trailing], 25)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        //
                    }
                }
            }
        }
    }
}

struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        Activity()
    }
}
