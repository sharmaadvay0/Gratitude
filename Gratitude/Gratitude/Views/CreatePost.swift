//
//  CreatePost.swift
//  Gratitude
//
//  Created by William Wu on 4/9/21.
//

import SwiftUI

struct CreatePost: View {
    @Binding var isShown: Bool
    @State private var mood: Double = 4.0
    @State private var categories: [String: Bool] = ["Family": false, "Friends": false, "Nature": false, "Community": false, "Career": false, "Education": false]
    @State private var postText: String = "Today I am feeling..."
    
    private let categoryRows: [[String]] = [["Family", "Friends", "Nature"], ["Community", "Career", "Education"]]
    
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
                    .padding([.top, .trailing], 25)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Mood")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Rate how you're feeling, from 0 to 5")
                                .font(.footnote)
                            
                            HStack {
                                Slider(value: $mood, in: 0...5, step: 0.1)
                                    .accentColor(Color(red: 242/255, green: 163/255, blue: 24/255))
                                Text(String(format: "%.1f", mood))
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 50.0)
                            }
                            
                            Text("Categories")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("What are you grateful for right now?")
                                .font(.footnote)
                            
                            VStack {
                                ForEach(categoryRows, id: \.self) { categoryRow in
                                    HStack {
                                        ForEach(categoryRow, id: \.self) { category in
                                            CategoryButton(selected: categories[category] ?? false, text: category)
                                                .onTapGesture {
                                                categories[category] = !(categories[category] ?? false)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Text("Description")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                            Text("Anything you'd like to share?")
                                .font(.footnote)
                            
                            TextEditor(text: $postText)
                                .padding(.horizontal, 4.0)
                                .frame(height: 150.0)
                                .background(Color(red: 255/255, green: 253/255, blue: 247/255))
                                .cornerRadius(4.0)
                                .foregroundColor(Color(white: 0.4))
                            
                            Button(action: {
                                print("make post")
                            }) {
                                ZStack {
                                    Capsule()
                                        .fill(Color(red: 242/255, green: 163/255, blue: 24/255))
                                        .frame(height: 40.0)
                                    Text("Create post")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                }
                            }
                            .padding(.top)
                        }
                        .padding([.top, .leading, .trailing])
                    }
                }
            }
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost(isShown: .constant(true))
    }
}

struct CategoryButton: View {
    private var selected: Bool = false
    private var text: String = ""
    
    init(selected: Bool, text: String) {
        self.selected = selected
        self.text = text
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(self.selected ? Color(red: 242/255, green: 163/255, blue: 24/255) : Color(red: 222/255, green: 222/255, blue: 222/255))
                .frame(height: 30.0)
            Text(self.text)
                .font(.footnote)
                .fontWeight(self.selected ? .bold : .regular)
                .foregroundColor(self.selected ? Color.white : Color(white: 0.4))
        }
    }
}
