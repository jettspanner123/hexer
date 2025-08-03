//
//  TextScrollViewContent.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI

struct TextScrollViewContent: View {
    var body: some View {
        ForEach(1...5, id: \.self) { _ in
            HStack {
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(.blue)
        }
    }
}

#Preview {
    TextScrollViewContent()
}
