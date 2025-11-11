//
//  ContentView.swift
//  Spotify2
//
//  Created by Giorgia Minetti on 07/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isPlaying = true
    @State private var progress: Double = 0.07
    @State var sliderValue: Double = 50
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.6),
                                            Color(red: 0.1, green: 0.01, blue: 0.09)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Daily Mix 1")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.headline)
                    .padding(.bottom)
                
                Image("cover_album")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                
                VStack(spacing: 4) {
                    Text("Relaxing Music")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("relax and sleep")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                VStack(spacing: 4) {
                    Slider(value: $sliderValue)
                        .accentColor(.white)
                        .padding(.horizontal)
                    HStack {
                        Text("0:07")
                        Spacer()
                        Text("-50:29")
                    }
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal)
                }
                
                HStack(spacing: 40) {
                    Button(action: {}) {
                        Image(systemName: "shuffle")
                            .foregroundColor(.white)
                    }
                    Button(action: {}) {
                                           Image(systemName: "backward.fill")
                                               .resizable()
                                               .frame(width: 24, height: 24)
                                               .foregroundColor(.white)
                                       }
                    Button(action: {
                                           isPlaying.toggle()
                                       }) {
                                           Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                               .resizable()
                                               .frame(width: 70, height: 70)
                                               .foregroundColor(.white)
                                       }
                    Button(action: {}) {
                                            Image(systemName: "forward.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.white)
                                        }
                                        Button(action: {}) {
                                            Image(systemName: "repeat")
                                                .foregroundColor(.white)
                                        }
                    
                                    
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}
