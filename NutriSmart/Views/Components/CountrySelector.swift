//
//  CountrySelector.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct CountrySelector: View {
    @Binding var selectedCountry: Country
    let countries: [Country]
    
    var body: some View {
        Picker("Country", selection: $selectedCountry) {
            ForEach(countries) { country in
                HStack {
                    Text(country.flag)
                    Text(country.name)
                }
                .tag(country)
            }
        }
    }
}

extension Country {
    var flag: String {
        switch id {
        case "rw": return "🇷🇼"
        case "ke": return "🇰🇪"
        case "ng": return "🇳🇬"
        case "in": return "🇮🇳"
        case "us": return "🇺🇸"
        default: return "🌍"
        }
    }
}

