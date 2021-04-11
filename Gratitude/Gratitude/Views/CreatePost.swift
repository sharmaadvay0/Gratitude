//
//  CreatePost.swift
//  Gratitude
//
//  Created by William Wu on 4/9/21.
//

import SwiftUI

struct CreatePost: View {
    @Binding var isShown: Bool
    @State private var moodRating: Double = 4.0
    @State private var selectedCategory: String = ""
    @State private var postText: String = ""
    
    @ObservedObject var networking = Networking()
    
    var completionHandler:() -> Void
    
    init(isShown: Binding<Bool>, completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
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
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        isShown = false
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
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
                            Slider(value: $moodRating, in: 0...5, step: 0.1)
                                .accentColor(Color(red: 242/255, green: 163/255, blue: 24/255))
                            Text(String(format: "%.1f", moodRating))
                                .multilineTextAlignment(.trailing)
                                .frame(width: 50.0)
                        }
                        
                        Text("Category")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 25)
                        Text("What are you grateful for right now?")
                            .font(.footnote)
                        
                        CategoryView(selectedCategory: $selectedCategory)
                        
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        Text("How are you feeling today?")
                            .font(.footnote)
                        
                        TextEditor(text: $postText)
                            .padding(.horizontal, 4.0)
                            .frame(height: 150.0)
                            .background(Color(red: 255/255, green: 253/255, blue: 247/255))
                            .cornerRadius(4.0)
                            .foregroundColor(Color(white: 0.4))
                        
                        Button(action: {
                            let post = NewPost(body: postText, category: selectedCategory, userMood: moodRating + 0.01, username: "justinyaodu")
                            networking.postNewPost(post: post) { (data, response, error) in
                                if (error == nil) {
                                    isShown = false
                                }
                                self.completionHandler()
                            }
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
                    .padding(.all)
                }
            }
        }
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost(isShown: .constant(true)) {
            
        }
    }
}

// this doesn't display properly in the preview, but works otherwise
struct CategoryView: View {
    @Binding var selectedCategory: String
    @State private var totalHeight = CGFloat.zero
    private let categories = Categories.categories
    private let categoryTitles = Categories.categoryTitles
    
    init(selectedCategory: Binding<String>) {
        _selectedCategory = selectedCategory
    }
    
    private func generateCategories(_ geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(categories, id: \.self) { category in
                CategoryButton(
                    selected: category == selectedCategory,
                    text: categoryTitles[category] ?? category
                )
                .onTapGesture {
                    selectedCategory = category
                }
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > geometry.size.width) {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if category == categories.last! {
                        width = 0
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { d in
                    let result = height
                    if category == categories.last! {
                        height = 0
                    }
                    return result
                })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                generateCategories(geometry)
            }
        }
        .frame(height: totalHeight)
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
        Text(self.text)
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundColor(self.selected ? Color.white : Color(white: 0.4))
            .padding(.vertical, 6.0)
            .padding(.horizontal, 15.0)
            .background(
                Capsule()
                    .fill(self.selected ? Color(red: 242/255, green: 163/255, blue: 24/255) : Color(red: 222/255, green: 222/255, blue: 222/255))
            )
            .padding(2.0)
    }
}
