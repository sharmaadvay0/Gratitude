//
//  CreatePost.swift
//  Gratitude
//
//  Created by William Wu on 4/9/21.
//

import SwiftUI

struct CreatePost: View {
    @State private var postText: String = ""
    
    var body: some View {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    TextEditor(text: $postText)
                        .frame(height: 150.0)
                        .border(Color.black, width: 1)
                    Text("Mood")
                    Text("Categories")
                    Spacer()
                }
                .padding(.all)
                .navigationBarTitle("Make a post")
            }
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost()
    }
}
