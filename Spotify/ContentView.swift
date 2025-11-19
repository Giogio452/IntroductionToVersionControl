//
//  ContentView.swift
//  Spotify
//
//  Created by Giorgia Minetti on 12/11/25.
//


import SwiftUI

struct ContentView: View {
    @State private var showSleepTimerSheet = false
    @State private var selectedTimer: Int? = nil
    @State private var isPlaying = false
    @State private var timer: Timer? = nil
    @State private var remainingTime: Int? = nil
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.7), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.down")
                            .font(.title3)
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    
                    Text("Relax Music")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        showSleepTimerSheet.toggle()
                    }, label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                    })
                    .sheet(isPresented: $showSleepTimerSheet) {
                        SleepTimerSheet(
                            selectedTimer: $selectedTimer,
                            remainingTime: $remainingTime,
                            isPlaying: $isPlaying,
                            startTimer: startTimer,
                            cancelTimer: cancelTimer
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding()
                
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
                .padding()
                
                
                VStack(spacing: 4) {
                    ProgressView(value: 0.35)
                        .tint(.white)
                        .frame(width: 320)
                    
                    HStack {
                        Text("1:12")
                        Spacer()
                        Text("40:48")
                    }
                    .foregroundColor(.white.opacity(0.6))
                    .font(.caption)
                    .frame(width: 320)
                }
                .padding()
                
                
                MediaControls(isPlaying: $isPlaying)
                    .padding()
                
                
                if let remaining = remainingTime, remaining > 0 {
                    Text("⏰ Sleep timer: \(remaining) min remaining")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.footnote)
                        .padding(.bottom, 10)
                }
                
                Spacer()
            }
        }
    }
    
    
    private func startTimer(minutes: Int) {
        timer?.invalidate() 
        selectedTimer = minutes
        remainingTime = minutes
        
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            if let remaining = remainingTime {
                if remaining > 1 {
                    remainingTime = remaining - 1
                } else {
                    // Timer finished
                    isPlaying = false
                    selectedTimer = nil
                    remainingTime = nil
                    timer?.invalidate()
                }
            }
        }
    }
    
    private func cancelTimer() {
        timer?.invalidate()
        selectedTimer = nil
        remainingTime = nil
    }
}

struct MediaControls: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        HStack(spacing: 35) {
            Button(action: {}, label: {
                Image(systemName: "shuffle")
            })
            .foregroundColor(.white)
            .font(.title2)
            
            Button(action: {}, label: {
                Image(systemName: "backward.fill")
            })
            .font(.system(size: 28))
            .foregroundColor(.white)
            
            // Play / Pause toggle
            Button(action: {
                isPlaying.toggle()
            }, label: {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
            })
            .font(.system(size: 65))
            .foregroundColor(.white)
            .shadow(radius: 2)
            
            Button(action: {}, label: {
                Image(systemName: "forward.fill")
            })
            .font(.system(size: 28))
            .foregroundColor(.white)
            
            Button(action: {}, label: {
                Image(systemName: "repeat")
            })
            .foregroundColor(.white)
            .font(.title2)
        }
        .padding(.horizontal, 10)
    }
}


struct SleepTimerSheet: View {
    @Binding var selectedTimer: Int?
    @Binding var remainingTime: Int?
    @Binding var isPlaying: Bool
    var startTimer: (Int) -> Void
    var cancelTimer: () -> Void
    
    @State private var inputMinutes: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Text("Set a Sleep Timer")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                VStack(spacing: 10) {
                    Text("Enter the duration in minutes")
                        .foregroundColor(.white.opacity(0.8))
                    
                    TextField("Es. 17", text: $inputMinutes)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .frame(width: 100)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    if let minutes = Int(inputMinutes), minutes > 0 {
                        startTimer(minutes)
                        dismiss()
                    }
                }) {
                    Text("Start timer")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                .padding(.top)
                
                if selectedTimer != nil {
                    Button(role: .destructive) {
                        cancelTimer()
                        dismiss()
                    } label: {
                        Text("Turn off the timer")
                            .foregroundColor(.red)
                    }
                    .padding(.top, 5)
                }
                
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.black, Color.blue.opacity(0.5)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ContentView()
}
