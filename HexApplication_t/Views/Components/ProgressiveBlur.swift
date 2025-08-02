//
//  ProgressiveBlur.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI

struct ProgressiveBlur: UIViewRepresentable {
    
    var removeAllFilters: Bool
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let bLayer = uiView.layer.sublayers?.first {
                if self.removeAllFilters {
                    bLayer.filters = []
                } else {
                    bLayer.filters?.removeAll(where: { filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    }
    
}

