//
//  CocktailFactory.swift
//  LookSmellTaste
//
//  Created by Hyunjun Kim on 12/12/23.
//

import SwiftUI

struct CocktailFactory: View {
    var ingredients: [CocktailIngredient]
    var totalAmount: Double {
        ingredients.reduce(0) { $0 + $1.amount }
    }
        
    var body: some View {
        ZStack {
            ZStack {
                glass
                if !ingredients.isEmpty {
                    cocktail
                    if ingredients.contains(where: { $0.name.lowercased() == "얼음" }) {
                        ice
                    }
                }
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .center)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(ingredients) { ingredient in
                        if ingredient.name != "얼음" {
                            HStack {
                                RoundedRectangle(cornerRadius: 2, style: .continuous)
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(getColor(colorName: ingredient.colorName))
                                Text(ingredient.name)
                                    .font(.gmarketSansCaption)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 100, height: 100)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var cocktail: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ForEach(ingredients) { ingredient in
                    let height = CGFloat(70 * ingredient.amount / totalAmount)
                    
                    Rectangle()
                        .frame(width: 60, height: height)
                        .foregroundStyle(getColor(colorName: ingredient.colorName))
                }
            }
            
            ZStack {
                ForEach(ingredients.indices, id: \.self) { index in
                    let accumulatedHeight = ingredients[0..<index].reduce(0) { $0 + CGFloat(70 * $1.amount / totalAmount) }
                    let ingredient = ingredients[index]
                    let height = CGFloat(70 * ingredient.amount / totalAmount) + accumulatedHeight
                    
                    Ellipse()
                        .frame(width: 60, height: 24)
                        .foregroundStyle(getColor(colorName: ingredient.colorName))
                        .offset(y: height)
                        .zIndex(Double(ingredients.count-index))
                }
            }
            .offset(y: -12)
            
            if let ingredient = ingredients.first {
                Ellipse()
                    .frame(width: 60, height: 24)
                    .foregroundStyle(getColor(colorName: ingredient.colorName))
                    .offset(y: -12)
                    .brightness(0.1)
                    .grayscale(0.2)
            }
        }
        .offset(y: 12)
    }
    
    private var glass: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Ellipse()
                    .frame(width: 70, height: 30)
                    .offset(y: 15)
                    .zIndex(1)
                    .foregroundStyle(.glass)
                    .brightness(0.1)
                Rectangle()
                    .frame(width: 70, height: 100)
                    .foregroundStyle(.glass)
                Ellipse()
                    .frame(width: 70, height: 30)
                    .offset(y: -15)
                    .foregroundStyle(.glass)
            }
            Ellipse()
                .strokeBorder(lineWidth: 4)
                .frame(width: 70, height: 30)
                .offset(y: 15)
                .zIndex(1)
                .foregroundStyle(.glass)
        }
    }
    
    private var ice: some View {
        ZStack {
            VStack {
                Text("🧊")
                    .rotationEffect(.degrees(10))
                Text("🧊")
                    .offset(x: 10)
                    .rotationEffect(.degrees(-15))
                Text("🧊")
                    .offset(x: -10)
                    .rotationEffect(.degrees(20))
            }
        }
        .frame(width: 60, height: 70, alignment: .top)
        .font(.tossFaceMedium)
        .opacity(0.4)
        .offset(y: 12)
    }
    
    private func getColor(colorName: String) -> Color {
        let colorMap: [String: Color] = [
            "blue": .blue,
            "red": .red,
            "green": .green,
            "indigo": .indigo,
            "yellow": .yellow,
            "gray": .gray,
            "orange": .orange,
            "brown": .brown,
            "cyan": .cyan,
            "mint": .mint,
            "pink": .pink,
            "purple": .purple,
            "teal": .teal
        ]
        
        return colorMap[colorName] ?? .blue
    }
}

#Preview {
    ZStack {
        Color.appSheetBackground.ignoresSafeArea()
        CocktailFactory(ingredients: [
            CocktailIngredient(name: "얼음", amount: 0, colorName: "black"),
            CocktailIngredient(name: "와인", amount: 1, colorName: "blue"),
            CocktailIngredient(name: "커피", amount: 2, colorName: "red"),
            CocktailIngredient(name: "칵테일", amount: 3, colorName: "green"),
            CocktailIngredient(name: "위스키", amount: 2, colorName: "orange"),
            CocktailIngredient(name: "자유", amount: 5, colorName: "yellow")
        ])
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
        .padding(.bottom, 5)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.appSheetBoxBackground)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}
