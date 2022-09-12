//
//  GameBoard.swift
//  IosTry
//
//  Created by Armin Keco on 06.09.22.
//

import SwiftUI
import AVKit
import AVFoundation


struct GameBoard: View {
    
    private var fourColumnGrid = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
  

   var cards = [CardBlock]()
    @Binding var settings: Int{
        mutating willSet
        {
            print(settings)
            self.reinitialize()
            
        }
    }
    var settingsOption = 0
    
    @State public var lives = 3
    @State var MatchedCards = [CardBlock]()
    @State var UserChoises = [CardBlock]()
    @State public var ScoreResult = 0
    @State var showingAlert = false
    @State private var allMatchesFound = false
    
    @State private var lastDeadline = DispatchTime.now()
    @State private var buttonDisabled = false
    
    init(settings: Binding<Int>) {
        self._settings = settings
        self.settings = settings.wrappedValue
        settingsOption = settings.wrappedValue // self.settings.getSettingsOption()
        if settingsOption == 8 {
            self.cards = generateArrayOfCardsObjects().shuffled()
        }
        else{
            self.cards = generateArrayOfCardsObjects12().shuffled()
        }
        
    }
    
    mutating func reinitialize(){
        
        if settingsOption == 8 {
            self.cards = generateArrayOfCardsObjects().shuffled()
        }
        else{
            self.cards = generateArrayOfCardsObjects12().shuffled()
        }

        lives = 3
        MatchedCards = [CardBlock]()
        UserChoises = [CardBlock]()
        ScoreResult = 0
        showingAlert = false
        allMatchesFound = false
    }
    
    func delayedUpdate(when currentDeadline: DispatchTime) {

            guard currentDeadline == lastDeadline else {
                return
            }
            reveilCards(go: false)
            buttonDisabled = false
        }
    
    var body: some View {

        ZStack{
          
                splashImageBackground.overlay(
                  
                    VStack{
                        
                        HStack{
                            Spacer()
                            VStack{
                            Text("Score").font(.headline).padding(.top, 10.0).foregroundColor(Color.white)
                            
                                Text(String(ScoreResult)).foregroundColor(Color.white).font(.largeTitle)
                            }
                            Spacer()
                            VStack{
                            Text("Lives").font(.headline).padding(.top, 10.0).foregroundColor(Color.white)
                            
                            Text(String(lives)).foregroundColor(Color.white).font(.largeTitle)
                            }
                            Spacer()
                        }
                        Spacer()
                        
                        Button("Reveil cards") {
                            reveilCards(go: true)
                            let deadline = DispatchTime.now() + 2.0
                                        self.lastDeadline = deadline
                                        buttonDisabled = true
                                        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                                            self.delayedUpdate(when: deadline)
                                        })

                        }.padding().background(Color(red:0, green: 0, blue: 0.5)).clipShape(Capsule()).opacity(0.7).disabled(buttonDisabled)
                            .alert("Game Over!", isPresented: $showingAlert) {
                                       Button("Restart game") {
                                           var counter = 0

                                           while (counter < cards.count){
                                               cards[counter].turnOver()
                                               counter+=1
                                           }
                                           
                                           //reinitialize()
                                   }
                            }
                        Spacer()
                        Spacer()
                        if settingsOption == 8 {
                        GeometryReader { geo in
                        LazyVGrid(columns: fourColumnGrid, spacing: 10){
                            let wdth = Int(geo.size.width/4-10)
                            ForEach(cards){
                                card in CardView(card: card,
                                                 width: wdth,
                                                 MatchedCards: $MatchedCards,
                                                 UserCoises: $UserChoises,
                                                 ScoreResult: $ScoreResult,
                                                 allMatchesFound: $allMatchesFound,
                                                 numberOfCards: $settings)
                            }
                        }
                        }
                        }
                        else{
                            GeometryReader { geo in
                            LazyVGrid(columns: fourColumnGrid, spacing: 5){
                                let wdth = Int(geo.size.width/4-5)
                                ForEach(cards){
                                    card in CardView(card: card,
                                                     width: wdth,
                                                     MatchedCards: $MatchedCards,
                                                     UserCoises: $UserChoises,
                                                     ScoreResult: $ScoreResult,
                                                     allMatchesFound: $allMatchesFound,
                                                     numberOfCards: $settings)
                                }
                            }
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                )
                .background(PlayerView().aspectRatio(contentMode: ContentMode.fill))
         
            }
        .alert("You won!", isPresented: $allMatchesFound) {
                   Button("Restart game") {
                       reveilCards(go: false)
                       //self.reinitialize()
               }
        }
    }
    
    private var splashImageBackground: some View {
        GeometryReader{ geo in
            PlayerView()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height+100)
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.2))
                .blur(radius: 1)
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        }
    }
    
    
     func reveilCards(go: Bool){
        var counter = 0
        while (counter < cards.count){
            cards[counter].turnOver()
            counter+=1
        }

        if(go == true){
            lives-=1
        }

        if(lives == 0){
            showingAlert = true;
        }
        
       
    }
    

}

//struct GameBoard_Previews: PreviewProvider {
//    static var previews: some View {
//        GameBoard()
//
//    }
//}

