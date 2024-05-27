//
//  SearchResultView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 10/5/24.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var searchString: String
    @Binding var isLoadingSearch: Bool
    @Binding var listSearch: SearchResponseModel
    @State var tabSelection: Int = 0
    @State var isPresentedFilter = false

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea(.all)

            VStack {
                ResultUserView()

                TabSelectionSearchView(tabSelection: $tabSelection, selectionButtons: ["Liên quan", "Mới nhất", "Giảm giá"])
                TabView(selection: $tabSelection) {
//                    Tab Liên quan
                    RelatedResultTabView(isLoadingSearch: $isLoadingSearch, listSearch: $listSearch)
                        .tag(0)
//                    Tab Mới nhất
                    NewestResultTabView().tag(1)
//                    Tab Giảm giá
                    SaleResultTabView().tag(2)
                }
            }
        }
        .searchable(text: $searchString, prompt: Text("Tìm Khoá Học"))
        .navigationTitle("Tìm kiếm khoá học")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresentedFilter) {
            VStack {
                Text("Filter ở đây")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        print("Save button tapped")
                        isPresentedFilter = false
                    }
                }
            }
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
                    isPresentedFilter.toggle()
                }, label: {
                    HStack(spacing: 8) {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                    .padding(8)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.25)
                            .stroke(Color(red: 0.26, green: 0.52, blue: 0.96), lineWidth: 0.25)
                    )
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchResultView(searchString: .constant(""), isLoadingSearch: .constant(true), listSearch: .constant(.init(course: [], quiz: [], blog: [])))
    }
}
