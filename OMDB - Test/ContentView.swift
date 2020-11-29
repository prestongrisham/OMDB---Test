//
//  ContentView.swift
//  OMDB - Test
//
//  Created by Preston Grisham on 6/13/20.
//  Copyright © 2020 Preston Grisham. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var movieManager = MovieManager(movieName: "Wedding Crashers")
    @State var movieName: String = ""
    @State var textFieldPlaceholder = "Enter Movie Name"
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.white)
                .gesture(TapGesture().onEnded { self.endEditing() })
            
            VStack {
                TextField($textFieldPlaceholder.wrappedValue, text: $movieName, onCommit: {
                    self.movieManager.getMovie(movieName: self.movieName)
                    self.movieName = ""
                }).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Image(uiImage: movieManager.image)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(movieManager.title)
                        .font(.title)
                    Text(movieManager.plot)
                }.padding()
                
                Text("Rotten Tomatoes Rating: \(self.movieManager.ratings)")
                    .fontWeight(.bold)
                
                Spacer()
            } //: VStack
            .gesture(TapGesture().onEnded { self.endEditing() })
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

