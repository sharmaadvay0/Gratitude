//
//  PostDetails.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import SwiftUI

struct PostDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            HStack {
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                    Image(systemName: "chevron.backward").resizable().foregroundColor(.black).frame(width:15, height: 25)
                })
                Spacer()
            }.padding(.leading, 25).padding(.top, 10)
            Spacer()
        }
    }
}

struct PostDetails_Previews: PreviewProvider {
    static var previews: some View {
        PostDetails()
    }
}
