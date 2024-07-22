//
//  StatsRatioView.swift
//  WineMe
//
//  Created by Kamajabu on 21/07/2024.
//

import SwiftUI

struct StatsRatioView: View {
    var ratio: Double
       
       var body: some View {
           HStack {
               ForEach(0..<5) { index in
                   ZStack {
                       Image(systemName: "star")
                           .font(.callout)
                           .foregroundColor(.gray)
                       
                       Image(systemName: "star.fill")
                           .font(.callout)
                           .foregroundColor(.orange)
                           .mask(
                               Rectangle()
                                   .frame(width: starWidth(for: index))
                           ).shadow(color: .black, radius: 0.5)
                   }
                   .frame(width: 20, height: 20)
               }
           }
       }
       
       private func starWidth(for index: Int) -> CGFloat {
           let fullStar = Double(index + 1)
           
           if ratio >= fullStar {
               return 20
           } else if ratio > Double(index) && ratio < fullStar {
               return CGFloat(ratio - Double(index)) * 20
           } else {
               return 0
           }
       }
}

#Preview {
    StatsRatioView(ratio: 3)
}
