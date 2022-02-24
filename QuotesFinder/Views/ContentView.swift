//
//  ContentView.swift
//  QuotesFinder
//
//  Created by Winston Wang on 2022-02-23.
//

import SwiftUI

struct ContentView: View {
    @State var currentQuote: QuoteFinder = QuoteFinder(quoteText: "adsfrdsa", quoteAuthor: "quoteAuthor", senderName: "heheheha", senderLink: "", quoteLink: "")
    
    @State var favourites: [QuoteFinder] = []
    
    @State var currentQuoteAddedToFavourrites: Bool = false
    var body: some View {
        VStack{
            Text(currentQuote.quoteText)
                .font(.title)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding()
            Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(currentQuoteAddedToFavourrites == true ? .red : .secondary)
                .onTapGesture {
                    
                    if currentQuoteAddedToFavourrites == false{
                        favourites.append(currentQuote)
                        
                        currentQuoteAddedToFavourrites = true
                    }
                    
                }
            
            Button(action:{
                
                Task {
                    await loadNewQuote()
                }
                
            }, label: {
                Text("Another One!!!")
            })
                .buttonStyle(.bordered)
                .padding()
            
            HStack{
                Text("Favourites")
                Spacer()
                    .padding()
            }
            
            List(favourites, id: \.self) {currentFavourite in
                Text(currentFavourite.quoteText)
            }
            
            Spacer()
            
        }
        
        .task {
            await loadNewQuote()
        }
        .navigationTitle("quotes")
        .padding()
        
    }
    
    func loadNewQuote() async {
        let url = URL(string: "http://forismatic.com/en/api/")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            
            currentQuote = try JSONDecoder().decode(QuoteFinder.self, from: data)
            
            currentQuoteAddedToFavourrites = false
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            print(error)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
