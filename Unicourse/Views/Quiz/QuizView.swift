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
            List {
                ForEach(viewModel.filteredQuizzes, id: \._id) { quiz in
                    NavigationLink(destination: QuizDetailView()) {
                        QuizItemView(quizItem: quiz)
                    }
                }
            }
            .listRowSeparator(.hidden, edges: .all)
            .listStyle(.inset)
        }
        .navigationTitle("Ôn tập 📚")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $viewModel.searchString, isPresented: $viewModel.isSearchBarVisible, prompt: Text("Nhập mã môn"))
        .sheet(isPresented: $viewModel.isPresentedFilter, content: {
            Text("Filter here")
                .presentationDetents([.medium, .large])
        })
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.error), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            Task {
                viewModel.isLoadingFetch = true
                await viewModel.getAllQuizzes()
                viewModel.isLoadingFetch = false
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
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 10, height: 18)
                            .padding(.trailing, 15)
                    }
                    Button(action: {
                        withAnimation {
                            viewModel.isSearchBarVisible = true
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: 10, height: 18)
                            .padding(.trailing, 15)
                    }
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
