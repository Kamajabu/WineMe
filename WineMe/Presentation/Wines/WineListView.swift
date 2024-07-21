//
//  WineListView.swift
//  WineMe
//
//  Created by Kamajabu on 14/07/2024.
//

import NukeUI
import Shimmer
import SwiftUI

struct WineListView: View {
    @ObservedObject var viewModel: WineListViewModel

    @State var wineType: WineType = .reds
    @State private var colorMode: Int = 0

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                wineListView

                CirclePicker(options: WineType.allCases, selected: $wineType)
                    .padding(.horizontal, 30)
            }
            .navigationTitle("Wines (\(wineType.name))")
            .font(.title2)
            .toolbarBackground(.thinMaterial, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Picker("Color", selection: $colorMode) {
                        Text("Light").tag(0)
                        Text("Dark").tag(1)
                    }
                    .pickerStyle(.inline)
                }
            }
            .task(id: wineType) {
                await viewModel.downloadWines(type: wineType)
            }
            .preferredColorScheme(colorMode == 0 ? .light : .dark)
        }
    }

    private var wineListView: some View {
        ScrollView {
            LazyVStack {
                if viewModel.wines.isEmpty {
                    ForEach(1 ..< 10) { model in
                        WineCellView(viewModel: .init(model: MockWineRepository.mockWineArray.first!,
                                                      imageDownloader: MockImageProvider()))
                            .wineCellSize()
                            .transition(.blurReplace)
                            .redacted(reason: .placeholder)
                            .opacity(0.2)
                    }
                } else {
                    ForEach(viewModel.wines, id: \.hashValue) { model in
                        WineCellView(viewModel: WineCellViewModel(model: model,
                                                                  imageDownloader: NukeImageProvider()))
                            .scrollTransition(.animated.threshold(.visible(0.3))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                    .blur(radius: phase.isIdentity ? 0 : 2)
                            }
                            .wineCellSize()
                            .transition(.blurReplace)
                    }
                }
            }
            .animation(.bouncy, value: viewModel.wines)
        }
    }
}

private extension View {
    func wineCellSize() -> some View {
        frame(height: 150)
            .padding([.horizontal], 10)
            .padding(.top, 5)
    }
}

#Preview {
    WineListView(viewModel: WineListViewModel(repository: MockWineRepository()))
}
