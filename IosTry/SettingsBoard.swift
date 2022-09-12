//
//  SettingsBoard.swift
//  IosTry
//
//  Created by Armin Keco on 12.09.22.
//

import SwiftUI
import AVKit
import AVFoundation

struct SettingsBoard: View {
    @Binding var settings: Int
    
    let imagesNames8: [String] = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8",]
    let imagesNames12: [String] = ["image9", "image10", "image11", "image12", "image13", "image14", "image15", "image16", "image17", "image18", "image19", "image20"]
    
    var body: some View {
        ZStack{
          
                splashImageBackground.overlay(
                  
                    VStack{

                            Spacer()
                        VStack(spacing: 20){
                         Text("Number of Cards").font(.headline).padding(.top, 10.0).foregroundColor(Color.white)

                            Picker(selection: $settings, label: Text("Number of cards")) {
                                    Text("8").tag(8).foregroundColor(Color.white)
                                    Text("12").tag(12).foregroundColor(Color.white)
                                                
                                            }
                                .pickerStyle(.segmented).foregroundColor(Color.white)
                           
                            }
                            Spacer()
                            VStack{
                            Text("Cards first option").font(.headline).padding(.top, 10.0).foregroundColor(Color.white)
                            
                                HStack{
                                    ForEach(imagesNames8, id: \.self) { crd in
                                        Image(crd).resizable()
                                            .frame(width: 32.0, height: 32.0)
                                      }
                                }
                            }
                            Spacer()
                        VStack{
                        Text("Cards second option").font(.headline).padding(.top, 10.0).foregroundColor(Color.white)
                        
                            HStack{
                                ForEach(imagesNames12, id: \.self) { crd in
                                    Image(crd).resizable()
                                        .frame(width: 26.0, height: 26.0)
                                  }
                            }
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                )
                .background(PlayerView().aspectRatio(contentMode: ContentMode.fill))
         
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
}

//struct SettingsBoard_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsBoard()
//    }
//}
