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

    @State private var wineType: WineType = .reds
    @AppStorage("colorScheme") var selectedColorScheme: AppColorScheme = .dark

    @Environment(\.colorScheme) var colorScheme

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
                    Picker(selection: $selectedColorScheme, label: Text("Color Scheme")) {
                        Text(AppColorScheme.light.label).tag(AppColorScheme.light)
                        Text(AppColorScheme.dark.label).tag(AppColorScheme.dark)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .animation(.easeInOut, value: wineType)
            .task(id: wineType) {
                await viewModel.downloadWines(type: wineType)
            }
            .preferredColorScheme(selectedColorScheme.systemScheme)
            .onAppear {
                selectedColorScheme = AppColorScheme(systemScheme: colorScheme)
            }
            .navigationDestination(for: WineDTO.self) { wine in
                VStack {
                    Text("You selected \(wine.label)")
                    if let rating = Double(wine.rating.average) {
                        StatsRatioView(ratio: rating)
                    }
                    Text("\(wine.location)")

                }
            }
        }
    }

    private var wineListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
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
                        NavigationLink(value: model) {
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
                        .tint(.primary)
                    }
                }
            }
            .animation(.bouncy, value: viewModel.wines)
        }
    }
}

private extension View {
    func wineCellSize() -> some View {
        frame(height: 160)
            .padding([.horizontal], 10)
    }
}

 #Preview {
    WineListView(viewModel: WineListViewModel(repository: MockWineRepository()))
 }
