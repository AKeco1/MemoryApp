//
//  CardView.swift
//  IosTry
//
//  Created by Armin Keco on 12.09.22.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var card: CardBlock
    let width:Int
    @Binding var MatchedCards: [CardBlock]
    @Binding var UserCoises: [CardBlock]
    @Binding var ScoreResult:Int
    @Binding var allMatchesFound: Bool
    @Binding var numberOfCards: Int
    var body: some View {
        //in this case display the card
        if(card.isClicked || MatchedCards.contains(where: {$0.id == card.id}))
        {
            Image(card.imageName)
        }else{ //display back side of card
            Image(card.defaultImageName)
                .onTapGesture(perform: {
                    if UserCoises.count == 0 {
                        card.turnOver()
                        UserCoises.append(card)
                    }
                    else if UserCoises.count == 1 {
                        card.turnOver()
                        UserCoises.append(card)
                        withAnimation(Animation.linear.delay(1)){
                            for thisCard in UserCoises {
                                thisCard.turnOver()
                            }
                            
                        }
                        checkMatch()
                    }
                })
        }
    }
    
    func checkMatch(){
        if UserCoises[0].imageName == UserCoises[1].imageName{
            MatchedCards.append(UserCoises[0])
            MatchedCards.append(UserCoises[1])
            ScoreResult+=1
        }
        
        checkIfAllFound()
        UserCoises.removeAll()
    }
    
    func checkIfAllFound(){
        if numberOfCards == 8 {
            let result = imagesNames8.count // == MatchedCards.count
            let match = MatchedCards.count
            if(result == match / 2){
                //that means all are found
                allMatchesFound = true
            }
        }
        else{
            let result = imagesNames12.count // == MatchedCards.count
            let match = MatchedCards.count
            if(result == match / 2){
                //that means all are found
                allMatchesFound = true
            }
        }
        
    
    }
}

