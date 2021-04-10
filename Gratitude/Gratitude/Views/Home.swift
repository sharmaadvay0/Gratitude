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
    
    var body: some View {
        
        ZStack {
            Color(red: 255 / 255, green: 246 / 255, blue: 225 / 255)
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                   
                            Text(self.getCurrentDate() + "th").padding(.bottom, 5).font(.system(size: 16))
                       
                        Text("Welcome Name!").font(.system(size: 24)).fontWeight(.bold)
                    }.padding(.leading, 25).padding(.top, 10)
                    Spacer()
                    Button(action: {
                        print("plus")
                    }, label: {
                        Image(systemName: "plus").resizable()
                        .frame(width: 24, height: 24, alignment: .center).foregroundColor(.black).padding(.top, 10)
                    })
                }.padding(.trailing, 25)
                Spacer()
            }


        }
    }
}

struct Title: View {
    var body: some View {
        Text("title")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
