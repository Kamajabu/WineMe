//
//  WineDetailsView.swift
//  WineMe
//
//  Created by Kamajabu on 24/07/2024.
//

import SwiftUI

struct WineDetailView: View {
    @Environment(\.dismiss) var dismiss

    let wine: WineDTO
    @State private var showFullImage = false
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [.purple, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                AsyncImage(url: URL(string: wine.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 10)
                        .onTapGesture {
                            withAnimation {
                                showFullImage.toggle()
                            }
                        }
                } placeholder: {
                    ProgressView()
                }
                .padding()
//                .fill(.thickMaterial)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(wine.winery)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                    
                    Text(wine.wine)
                        .font(.title)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(radius: 10)
                    
                    HStack {
                        Text("Rating: \(wine.rating.average)")
                        Text("(\(wine.rating.reviews) reviews)")
                    }
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(radius: 10)
                    
                    Text(wine.location)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Close")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding(.horizontal, 20)
                }
                .padding()
//                .background(BlurView(style: .systemThinMaterialDark))
                .cornerRadius(20)
                .shadow(radius: 20)
            }
        }
        .fullScreenCover(isPresented: $showFullImage) {
            FullImageView(imageUrl: wine.image, showFullImage: $showFullImage)
        }
    }
}

struct FullImageView: View {
    let imageUrl: String
    @Binding var showFullImage: Bool
    
    var body: some View {
        ZStack {
            // Different gradient background
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 10)
                } placeholder: {
                    ProgressView()
                }
                .padding()
//                .fill(.thickMaterial)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        showFullImage = false
                    }
                }) {
                    Text("Close")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    WineDetailView(wine: MockWineRepository.mockWineArray[2])
}
