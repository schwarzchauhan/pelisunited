//
//  SwiftUIUtils.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/15/25.
//

import SwiftUI

extension Text {
    func playButton() -> some View {
        self
            .foregroundStyle(.buttonTextLight)
            .bold()
            .padding(.all, 8)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            }
    }
    func downloadButton() -> some View {
        self
            .foregroundStyle(.buttonText)
            .bold()
            .padding(.all, 8)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 2.0)
            }
    }
    
    func titleText() -> some View {
        self
            .font(.title)
    }
}


extension Image {
    func standardImage() -> some View {
        self
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
