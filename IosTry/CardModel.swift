//
//  CardModel.swift
//  IosTry
//
//  Created by Armin Keco on 11.09.22.
//

import Foundation

class CardBlock: Identifiable, ObservableObject {
    
    @Published var isClicked = false
    @Published var isMatch = false
    var id  = UUID()
    var imageName: String
    var defaultImageName = "default"
     
    
    init(text: String) {
        self.imageName = text
        self.defaultImageName = "default"
    }
    
    func turnOver(){
        self.isClicked.toggle()
    }
    
    func turnDown(){
        self.isClicked.toggle()
    }
    
}
let imagesNames8: [String] = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8",]
let imagesNames12: [String] = ["image9", "image10", "image11", "image12", "image13", "image14", "image15", "image16", "image17", "image18", "image19", "image20"]
//let faceDown = CardBlock(text: "default")
func generateArrayOfCardsObjects() -> [CardBlock]{
    
    var listOfCardObjects = [CardBlock]()
    
    for card in imagesNames8 {
        listOfCardObjects.append(CardBlock(text: card))
        listOfCardObjects.append(CardBlock(text: card))
    }
    
    return listOfCardObjects
}

func generateArrayOfCardsObjects12() -> [CardBlock]{
    
    var listOfCardObjects = [CardBlock]()
    
    for card in imagesNames12 {
        listOfCardObjects.append(CardBlock(text: card))
        listOfCardObjects.append(CardBlock(text: card))
    }
    
    return listOfCardObjects
}
