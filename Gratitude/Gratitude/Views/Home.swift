//
//  Home.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/9/21.
//

import SwiftUI

struct Home: View {
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        return formatter.string(from: date)
    }
    @State var makePost = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color(red: 255 / 255, green: 246 / 255, blue: 225 / 255)
                    .ignoresSafeArea()
                VStack {
                    
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading) {
                            
                            Text(self.getCurrentDate() + "th")
                                .padding(.bottom, 5)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.init(red: 130/255, green: 130/255, blue: 130/255))
                            
                            Text("Welcome Name!").font(.system(size: 24)).fontWeight(.bold)
                            
                        }.padding(.leading, 25).padding(.top, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            makePost = true
                        }, label: {
                            
                            Image(systemName: "plus").resizable()
                                .frame(width: 24, height: 24, alignment: .center).foregroundColor(.black).padding(.top, 10)
                            
                        })
                    }.padding(.trailing, 25)
                    
                    ListOfPosts()
                    
                    
                    Spacer()
                }
                
                
            }.sheet(isPresented: $makePost, content: {
                Text("Make Post View Here")
            })
        }.padding(.top, -90)
        
        
    }
}

struct PostPreview: View {
    let name: String?
    let info: String?
    
    var body: some View {
        Button(action: {
            print("Clicked Post")
        }) {
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(name ?? "Name Here").padding(.bottom, 10).font(.system(size: 20, weight: .bold)).foregroundColor(.init(red: 130/255, green: 130/255, blue: 130/255))
                        Text(info ?? "Info Here").foregroundColor(.black)
                    }.padding()
                    Spacer()
                }
            }
            .background (
                RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.white)
            ).padding([.trailing,.leading], 25)
            .padding(.top, 10)
        }
        
        
        
        
    }
}

struct ListOfPosts: View {
    var n = 0
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10) {
                    number in
                    PostPreview(name: "Test Name", info: "Test Info")
                }
            }.padding(.bottom, 100)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
