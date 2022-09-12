//
//  SettingsModel.swift
//  IosTry
//
//  Created by Armin Keco on 12.09.22.
//

import Foundation
import SwiftUI

class SettingsModel :Identifiable, ObservableObject{
    @Published var numberOfCardsSelection = 8
    let imagesNames8: [String] = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8",]
    let imagesNames12: [String] = ["image9", "image10", "image11", "image12", "image13", "image14", "image15", "image16", "image17", "image18", "image19", "image20"]
    
    init() {
        self.numberOfCardsSelection = 8
    }
    
    func getSettingsOption() -> Int{
        return self.numberOfCardsSelection
    }
}



