//
//  NavigationBar.swift
//  LookSmellTaste
//
//  Created by hyunjun on 11/5/23.
//

import SwiftUI

enum ViewType: String {
    case note = "노트"
    case share = "공유"
}

struct NavigationTitle: View {
    var type: ViewType = .note
    var scrollOffset = 0.0
    
    var body: some View {
        HStack {
            Text(type.rawValue)
                .font(.gmarketSansTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .scaleEffect(min(1 + scrollOffset / 300, 1.2), anchor: .leading)
            Circle()
                .frame(width: 25)
                .foregroundStyle(.gray.opacity(0.5))
                .scaleEffect(min(1 + scrollOffset / 300, 1.2), anchor: .trailing)
        }
        .padding(.top, 10)
        .opacity(scrollOffset > -15 ? 1 : 0)
        .padding(.leading, 20)
        .padding(.trailing, 15)
    }
}

struct InlineNavigationTitle: View {
    var type: ViewType = .note
    var scrollOffset = -40.0
    
    var body: some View {
        HStack {
            Text(type.rawValue)
                .font(.gmarketSansTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .scaleEffect(0.95, anchor: .leading)
            Circle()
                .frame(width: 25)
                .foregroundStyle(.gray.opacity(0.5))
                .scaleEffect(0.95, anchor: .trailing)
        }
        .padding(.leading, 20)
        .padding(.trailing, 15)
        .padding(.bottom, 3)
        .background {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .padding(.top, -5)
        .frame(maxHeight: .infinity, alignment: .top)
        .opacity(scrollOffset < -14.9 ? 1 : 0)
    }
}

#Preview {
    ScrollView {
        NavigationTitle()
    }
    .overlay {
        InlineNavigationTitle()
    }
}
