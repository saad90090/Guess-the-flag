//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Saad Ahmad on 16/09/2026.
//

import SwiftUI

struct FlagImage : ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.capsule)
            .shadow(radius: 5)
    }

}
extension View {
    func imageStyle() -> some View{
        modifier(FlagImage())
    }
}
struct ContentView: View {
   @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
   @State private var selectedCountry = Int.random(in:0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var highScore = 0
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("Select the correct country flag:")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.heavy))
                Text(countries[selectedCountry])
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.bold))
                VStack (spacing: 30){
                    ForEach(0..<3){ number in
                        Button{
                            correctOption(number : number)
                        }
                        label:{
                            Image(countries[number])
                                .imageStyle()
                        }
                    }
                }
                .padding( )
            }
         
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("Continue" , action: askQuestion)
        } message: {
            Text("Your score is \(highScore)")
        }
    }
    func correctOption(number : Int){
        if number == selectedCountry {
           scoreTitle = "Correct!"
            highScore += 1
        }
        else {
            scoreTitle = "Wrong!"
        }
        showingScore = true
        
    }
    func askQuestion(){
        countries.shuffle()
        selectedCountry = Int.random(in:0...2)
    }
}
#Preview {
    ContentView()
}
