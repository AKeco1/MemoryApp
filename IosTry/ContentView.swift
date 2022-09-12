//
//  ContentView.swift
//  IosTry
//
//  Created by Armin Keco on 06.09.22.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Load the resource -> h
        let fileUrl = Bundle.main.url(forResource: "backgroundearth", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        // Start the movie
        player.play()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}


struct ContentView: View {
    @State private var isStartNewGameChoosen = false
    @State private var isSettingsChoosen = false
    @State private var settings = Int()
    var body: some View {
        NavigationView {
        ZStack{

                splashImageBackground.overlay(

                    VStack{
                        NavigationLink(destination: GameBoard(settings: self.$settings), isActive: $isStartNewGameChoosen) {
                            Button("Start New Game"){
                                self.isStartNewGameChoosen = true;
                            }.padding().background(Color(red:0, green: 0, blue: 0.5)).clipShape(Capsule()).opacity(0.7)
                        }
                        NavigationLink(destination: SettingsBoard(settings: self.$settings)
                            
                        , isActive: $isSettingsChoosen) {
                            Button("Settings"){
                                self.isSettingsChoosen = true;
                            }.padding().background(Color(red:0, green: 0, blue: 0.5)).clipShape(Capsule()).opacity(0.7)
                        }
                    }
                        .padding(.horizontal).ignoresSafeArea()


                )

                .background(PlayerView().aspectRatio(contentMode: ContentMode.fill))
         
            }
        
       }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(PlayerView().aspectRatio(contentMode: ContentMode.fill))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
