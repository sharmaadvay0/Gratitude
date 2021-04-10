//
//  CreatePost.swift
//  Gratitude
//
//  Created by William Wu on 4/9/21.
//

import SwiftUI

struct CreatePost: View {
    @Binding var isShown: Bool
    @State private var postText: String = "I am thankful for..."
    
    init(isShown: Binding<Bool>) {
        _isShown = isShown
        UITextView.appearance().backgroundColor = .clear
    }
    
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
                        
                        Spacer()
                        
                        Button(action: {
                            isShown = false
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        })
                    }
                    .padding(.trailing, 25)
                    
                    VStack(alignment: .leading) {
                        Text("Mood")
                        
                        Text("Categories")
                        
                        TextEditor(text: $postText)
                            .padding(.horizontal, 4.0)
                            .frame(height: 150.0)
                            .background(Color(red: 255/255, green: 253/255, blue: 247/255))
                            .cornerRadius(4.0)
                            .foregroundColor(Color.gray)
                        
                        Spacer()
                    }
                    .padding(.all)
                }
            }
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost(isShown: .constant(true))
    }
}
