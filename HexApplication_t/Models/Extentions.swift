//
//  Extentions.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 02/08/25.
//

import SwiftUI

extension View {
    func applicationHorizontalPadding() -> some View {
        self
            .padding(.horizontal, Constants.current.paddingHorizontal)
    }
    
    func applicationPageVerticalPadding() -> some View {
        self
            .padding(.top, 85)
    }
}
