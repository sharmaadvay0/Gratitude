//
//  PostDetails.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import SwiftUI

struct PostDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var description: String = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit"
    private var category: String = Categories.categories[1]
    private var moodRating: Double = 4.0
    var body: some View {

            
            VStack {
                HStack {
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                        Image(systemName: "chevron.backward").resizable().foregroundColor(.black).frame(width:15, height: 25)
                    })
                    Text("April 9th").fontWeight(.bold).font(.largeTitle).padding(.leading, 10)
                    Spacer()
                }.padding(.leading, 25).padding(.top, 10)
                Text(description).padding([.leading,.trailing], 25).padding(.top, 10).font(.custom("details", size: 20))
                VStack(alignment: .leading) {
                    HStack {
                        Text("Category:").fontWeight(.bold).font(.title)
                        CategoryButton(selected: true, text: Categories.categoryTitles[category] ?? category)
                        Spacer()
                    }
                    
                    Text(String(format: "Mood Rating: %.1f", moodRating)).fontWeight(.bold).font(.title).padding(.top, 10)
                }.padding()
                Spacer()
            }
        
    }
}

struct PostDetails_Previews: PreviewProvider {
    static var previews: some View {
        PostDetails()
    }
}
