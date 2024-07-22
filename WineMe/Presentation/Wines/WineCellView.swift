//
//  WineCellView.swift
//  WineMe
//
//  Created by Kamajabu on 15/07/2024.
//

import Nuke
import SwiftUI

final class WineCellViewModel: ObservableObject {
    @Published var image: UIImage?
    
    let model: WineDTO
    let imageDownloader: ImageDownloader
    
    init(model: WineDTO, imageDownloader: ImageDownloader) {
        self.model = model
        self.imageDownloader = imageDownloader
    }
    
    @MainActor
    func downloadImage() async {
        guard let url = URL(string: model.image) else {
            image = .winePlaceholder
            return
        }
        
        do {
            image = try await imageDownloader.downloadImage(url: url)
        } catch {
            image = .winePlaceholder
        }
    }
}

extension WineCellView {
    struct Const {
        static let cornerRadius: CGFloat = 10
    }
}

struct WineCellView: View {
    @StateObject var viewModel: WineCellViewModel
    
    private let viewHeight: CGFloat = 160
        
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Group {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        
                    } else {
                        Rectangle()
                            .fill(Color.gray)
                    }
                }
                .frame(height: viewHeight)
                .opacity(0.2)
                .blur(radius: 30)
                .clipped()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(viewModel.model.winery)
                            .font(.caption2)
                            .italic()
                            .foregroundStyle(.gray)
                        
                        Text(viewModel.model.wine)
                            .font(.caption)
                            .foregroundStyle(.primary)
                        
                        if let rating = Double(viewModel.model.rating.average) {
                            StatsRatioView(ratio: rating)
                        }
                    }
                    .padding(10)
                    .background(.ultraThickMaterial)
                    .cornerRadius(Const.cornerRadius)
                    .padding()
                    .animation(.easeInOut, value: viewModel.model.wine)
                    
                    Spacer()
                    
                    ZStack(alignment: .center) {
                        if let image = viewModel.image {
                        Rectangle()
                            .fill(.thickMaterial)
                            .transition(.opacity)
                            .frame(height: viewHeight*2)
                            .rotationEffect(.degrees(30))
                            .frame(maxWidth: .infinity, maxHeight: viewHeight)
                            .shadow(radius: 4)
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .padding()
                                .frame(height: viewHeight)
                                .id(UUID())
                                .transition(.move(edge: .trailing))
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 10)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: viewModel.image)
            .frame(height: viewHeight)
            .background(.ultraThinMaterial)
            .cornerRadius(Const.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Const.cornerRadius)
                    .stroke(.thinMaterial, lineWidth: 1)
                    .shadow(radius: 3, x: 2, y: 2)
                    .opacity(0.8)
            )
        }
        .task {
            await viewModel.downloadImage()
        }
    }
}

#Preview {
    WineCellView(viewModel: .init(model: MockWineRepository.mockWineArray[4],
                                  imageDownloader: MockImageProvider()))
        .frame(maxWidth: .infinity)
        .frame(height: 150)

}
