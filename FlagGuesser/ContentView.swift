//
//  ContentView.swift
//  FlagGuesser
//
//  Created by Nusaiba Rahman on 8/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingSource = false
    @State private var scoreTitle = "1"
    @State private var currentScore = 0
    @State private var gameTitle = "Tap the flag of"
    @State private var subTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    

    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            VStack(spacing: 30) {
            
                VStack {
                    Text("\(gameTitle)")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))

                }
                
                ForEach(0..<3) { number in
                    Button {
                        //flag was tapped
                        flagTapped(number)

                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 20)
                    }
                }
                Text("Current score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.heavy))
                
                HStack(spacing: 20) {

                    Button("Restart Game", action: restartGame)
                        .foregroundColor(.white)
                        .buttonStyle(.borderedProminent)
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingSource) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(currentScore)")
        }
            
    }
    
    func flagTapped(_ number: Int) {

        if number == correctAnswer {
            scoreTitle = "Correct!"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingSource = true
        
        if hasWon() {
            gameTitle = "YOU'VE WON 🥳🎉"
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        countries = countries.shuffled()
        currentScore = 0
    }
    
    func hasWon() -> Bool {
        return currentScore == 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.dark)
    }
}
