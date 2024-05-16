//
//  RecentView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SwiftUI

struct RecentView: View {
    @State private var searchString: String = ""
    @State private var isSearchBarVisible: Bool = false
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        VStack {
            Text("Recent View")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        isSearchBarVisible.toggle()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                }
            }
        }
    }
}

#Preview {
    RecentView()
}
