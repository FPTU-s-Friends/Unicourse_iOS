//
//  QuizView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 31/5/24.
//
import SDWebImageSwiftUI
import SwiftUI

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    @State private var isFetchingInitial = true

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            if viewModel.isLoadingFetch == false, viewModel.filteredQuizzes.isEmpty {
                VStack {
                    Text("Không tìm thấy chủ đề phù hợp")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.mainColor1)
                }
            }

            if viewModel.isLoadingFetch {
                List {
                    ForEach(0 ..< 10) { _ in
                        SkeletonQuizItemListUI()
                    }
                }
                .listRowSeparator(.hidden, edges: .all)
                .listStyle(.inset)
                .navigationTitle("Ôn tập 📚")
                .navigationBarTitleDisplayMode(.large)
            } else {
                List {
                    ForEach(viewModel.filteredQuizzes, id: \._id) { quiz in
                        NavigationLink(destination: QuizDetailView(quizId: quiz._id)) {
                            QuizItemView(quizItem: quiz)
                        }
                    }
                }
                .listRowSeparator(.hidden, edges: .all)
                .listStyle(.inset)
                .navigationTitle("Ôn tập 📚")
                .toolbarBackground(Color.mainBackgroundColor, for: .navigationBar)
                .searchable(text: $viewModel.searchString, isPresented: $viewModel.isSearchBarVisible, prompt: Text("Nhập mã môn"))
                .sheet(isPresented: $viewModel.isPresentedFilter, content: {
                    Text("Filter here")
                        .presentationDetents([.medium, .large])
                })
                .refreshable {
                    Task {
                        viewModel.isLoadingFetch = true
                        await viewModel.getAllQuizzes()
                        viewModel.isLoadingFetch = false
                    }
                }
            }
        }

        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.error), dismissButton: .default(Text("OK")))
        }

        .onAppear {
            if isFetchingInitial {
                Task {
                    viewModel.isLoadingFetch = true
                    await viewModel.getAllQuizzes()
                    viewModel.isLoadingFetch = false
                    isFetchingInitial = false
                }
            }
        }
        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(action: {
                        viewModel.isPresentedFilter = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34)
                            .foregroundColor(.mainColor1)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.1)
                            )
                    }

                    ButtonSearchUIView(isSearchOpen: $viewModel.isSearchBarVisible)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
