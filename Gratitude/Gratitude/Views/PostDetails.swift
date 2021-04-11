//
//  PostDetails.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import SwiftUI

struct PostDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let categoryRows: [[String]] = [["Family", "Friends", "Nature"], ["Community", "Career", "Education"]]
    
    var name:String
    var info:String
    
    var body: some View {
        
        
        VStack {
            HStack {
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                    Image(systemName: "chevron.backward").resizable().foregroundColor(.black).frame(width:15, height: 25)
                })
                Text(name).fontWeight(.bold).font(.largeTitle).padding(.leading, 10)
                Spacer()
            }.padding(.leading, 25).padding(.top, 10)
            Text(info).padding([.leading,.trailing], 25).padding(.top, 10).font(.custom("details", size: 20))
            VStack(alignment: .leading) {
                Text("Categories").fontWeight(.bold).font(.title)
                ForEach(categoryRows, id: \.self) { categoryRow in
                    HStack {
                        ForEach(categoryRow, id: \.self) { category in
                            ZStack {
                                Capsule()
                                    .fill(Color(red: 242/255, green: 163/255, blue: 24/255))
                                    .frame(height: 30.0)
                                Text(category)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    
                }
                Text("Mood Rating: 4.0").fontWeight(.bold).font(.title).padding(.top, 10)
            }.padding()
            Spacer()
        }
        
    }
}

struct PostDetails_Previews: PreviewProvider {
    static var previews: some View {
        PostDetails(name: "Name", info: "Post Info")
    }
}
