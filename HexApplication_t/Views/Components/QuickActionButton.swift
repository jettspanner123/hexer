//
//  QuickActionButton.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI

struct QuickActionButton: View {
    var text: String
    var body: some View {
        HStack {
            Text(self.text)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.right")
                .foregroundStyle(.black)
                .scaleEffect(0.8)
                .padding(7)
                .background(.white, in: Circle())
                .padding()
        }
    }
}

