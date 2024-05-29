//
//  FavoriteView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 12/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct FavoriteView: View {
    @State var searchString: String = ""
    @State private var isSearchBarVisible: Bool = false
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss: DismissAction

    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 165), spacing: 20)], spacing: 10) {
                    ForEach(0 ..< 10) { _ in
                        ZStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                VStack {
                                    WebImage(url: URL(string: DefaultURL.defaultCourseURL)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 165)
                                    } placeholder: {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: .infinity, height: 165)
                                            .padding(10)
                                            .shimmerWithWave()
                                    }
                                }
                                .frame(width: 190)

                                VStack(alignment: .leading) {
                                    HStack {
                                        WebImage(url: URL(string: DefaultURL.defaultUserURL)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 23, height: 23)
                                                .cornerRadius(20)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Text("Unicourse")
                                            .font(.system(size: 10, weight: .medium))
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(1)
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.horizontal, 15)

                                    Text("Title khoá học")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .padding(.horizontal, 15)

                                    Spacer()
                                }

                                RatingStars(rating: 4)
                            }
                            .frame(width: 180, height: 260)
                            .background(.white)
                            .cornerRadius(12)
                        }
                    }
                }
                .searchable(text: $searchString, isPresented: $isSearchBarVisible, prompt: Text("Tìm kiếm"))
            }
            .background(Color.mainBackgroundColor)
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 10, height: 18)
                        .padding(.horizontal, 15)
                })
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation(.spring()) {
                        isSearchBarVisible.toggle()
                    }
                }, label: {
                    if !isSearchBarVisible {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 10, height: 18)
                            .padding(.horizontal, 15)
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
    }
}
