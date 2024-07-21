//
//  CirclePicker.swift
//  WineMe
//
//  Created by Kamajabu on 21/07/2024.
//

import SwiftUI

protocol CirclePickerOption: Hashable, Identifiable {
    var label: String { get }
}

enum CirclePickerConst {
    static let collapsedSize: CGFloat = 50
    static let extendedSize: CGFloat = 200

    static let extendedWidth: CGFloat = 200
    static let extendedHeight: CGFloat = 200
}

enum AnimationPhase: CaseIterable {
    case start, middle, end
}

struct CirclePicker<Option: CirclePickerOption>: View {
    @State var pickerExtended = false

    let options: [Option]
    @Binding var selected: Option

    @State private var animationStep = 0

    typealias Const = CirclePickerConst

    var size: CGFloat {
        pickerExtended ? Const.extendedSize : Const.collapsedSize
    }

    var offset: CGFloat {
        pickerExtended ? -Const.extendedSize / 2 : 0
    }

    enum IconType {
        case close
        case extend

        var sfSymbolName: String {
            switch self {
            case .close:
                "xmark"
            case .extend:
                "arrow.2.circlepath"
            }
        }
    }
    
    @State var scrolledID: Option.ID?

    @State var icon: IconType = .extend

    var iconName: String {
        let state: IconType = pickerExtended ? .close : .extend
        return state.sfSymbolName
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Capsule()
                .fill(.ultraThickMaterial)
                .frame(width: size, height: Const.collapsedSize)
                .shadow(radius: 4, x: 0, y: 5)

            if pickerExtended {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(options) { option in
                            Text(option.label)
                                .font(.caption)
                                .frame(width: 60, height: 30)
                                .background {
                                    if option == selected {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.ultraThickMaterial)
                                            .stroke(.primary, lineWidth: 1)
                                            .shadow(radius: 1)
                                    } else {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.thickMaterial)
                                    }
                             
                                }
                                .padding(4)
                                .scrollTransition(.animated.threshold(.visible(0.8))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.75)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                        .blur(radius: phase.isIdentity ? 0 : 1)
                                }
                   
                        }
                    }.scrollTargetLayout()
                }
                .scrollPosition(id: $scrolledID)
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 20)
                .frame(width: 140, height: Const.collapsedSize)
                .padding(.trailing, 50)
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .onChange(of: scrolledID) {
                    guard let selectedOption = options.first(where: { $0.id == scrolledID }) else { return }
                    selected = selectedOption
                }
            }

            Image(systemName: iconName)
                .font(.system(size: 20))
                .bold()
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(pickerExtended ? 0 : 360))
                .padding([.horizontal], 14)
                .onTapGesture {
                    withAnimation {
                        pickerExtended.toggle()
                    }
                }
        }
    }
}

#Preview {
    @State var selectedOption = "One"

    return HStack {
        Spacer()
        CirclePicker(options: ["One", "Two", "Three", "Four", "Five", "Six"], selected: $selectedOption)

    }.frame(maxWidth: .infinity)
}

extension String: CirclePickerOption {
    public var id: String {
        self
    }

    var label: String { self }
}