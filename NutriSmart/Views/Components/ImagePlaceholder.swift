//
//  ImagePlaceholder.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct ImagePlaceholder: View {
    let systemName: String
    let size: CGFloat
    
    init(systemName: String = "photo.fill", size: CGFloat = 100) {
        self.systemName = systemName
        self.size = size
    }
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .foregroundColor(.gray.opacity(0.3))
            .background(Color.gray.opacity(0.1))
    }
}

import UIKit

struct SafeImage: View {
    let name: String
    let placeholder: String
    let contentMode: ContentMode
    
    init(_ name: String, placeholder: String = "photo.fill", contentMode: ContentMode = .fill) {
        self.name = name
        self.placeholder = placeholder
        self.contentMode = contentMode
    }
    
    var body: some View {
        if let image = UIImage(named: name) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else {
            ImagePlaceholder(systemName: placeholder)
        }
    }
}

