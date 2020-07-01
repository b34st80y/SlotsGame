//
//  ContentView.swift
//  SlotsGame
//
//  Created by Adam Ghaffarian on 7/1/20.
//  Copyright © 2020 Adam Ghaffarian. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var credits: Int = 100
    @State private var slotState = [0, 1, 2]
    
    private var symbols = ["apple", "cherry", "star"]
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 200/233, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 228/233, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                TitleView()
                Spacer()
                CreditsView(credits: $credits)
                Spacer()
                SlotsView(symState: $slotState, symbols: symbols)
                Spacer()
                Spacer()
                SpinButton(credits: $credits, slotState: $slotState, numStates: symbols.count)
                Spacer()
            }.padding(.all)

        }
    }
}

struct TitleView: View {
    var body: some View {
        HStack{
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text("SwiftUI Slots")
                .bold()
                .foregroundColor(.white)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }.font(.title)
    }
}

struct CreditsView: View{
    @Binding var credits: Int
    var body: some View{
        Text("Credits: " + String(credits))
            .foregroundColor(.black)
            .padding(.all)
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
    }
}

struct SlotsView: View {
    @Binding var symState: [Int]
    var symbols: [String]
    var body: some View{
        HStack {
            SlotCard(imageName: symbols[symState[0]])
            SlotCard(imageName: symbols[symState[1]])
            SlotCard(imageName: symbols[symState[2]])
        }
    }
}

struct SlotCard: View {
    var imageName: String
    
    var body: some View {
        Image(imageName).resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
    }
}

struct SpinButton: View {
    @Binding var credits: Int
    @Binding var slotState: [Int]
    var numStates: Int
    
    let winnings = 50
    let cost = 5
    var body: some View{
        Button(action: {
            // Check Credits
            if self.credits < self.cost{
                // Not enough credits
                return
            }
            
            // Randomize Slots
            self.slotState = self.slotState.map({ _ in
                Int.random(in: 0...self.numStates-1)
            })
            
            // Check Slots
            if self.slotState[0] == self.slotState[1] &&
                self.slotState[1] == self.slotState[2]{
                // Match / Win
                self.credits += self.winnings
            } else {
                // No Match / Lose
                self.credits -= self.cost
            }
        }){
            Text("Spin")
                .bold()
                .foregroundColor(.white)
                .padding(.all, 10)
                .padding(.horizontal, 30)
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


