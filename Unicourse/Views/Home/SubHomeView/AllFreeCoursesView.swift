//
//  AllFreeCoursesView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 30/5/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct AllFreeCoursesView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject var viewModel = SearchEntryViewModel()
    @State private var isSearchBarVisible: Bool = false

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    if viewModel.isLoading {
                        ForEach(0 ..< 3) { _ in
                            SkeletonTopCourseItem()
                        }

                    } else {
                        ForEach(viewModel.listFreeCourse, id: \._id) { course in
                            NavigationLink(destination: CourseDetailView(courseId: course._id)) {
                                FreeCourseView(course: course)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 10)
                    }
                }

                if viewModel.isLoadingMore {
                    JustLoadingView(isLoading: .constant(true))
                        .padding(.horizontal, 10)
                }
            }
        }
        .searchable(text: $viewModel.searchString, isPresented: $isSearchBarVisible, prompt: Text("Tìm kiếm"))
        .navigationTitle("Khoá học miễn phí 📖")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
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

        .onDisappear {
            SDImageCache.shared.clearMemory()
        }
    }
}

struct FreeCourseView: View {
    var course: SearchCourseModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: course.thumbnail)!) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                }

                VStack(alignment: .leading) {
                    VStack {
                        Text(course.title)
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                            .padding(.horizontal, 5)
                    }
                    HStack(alignment: .center) {
                        RatingStars(rating: 4, maxRating: 5)
                        Text("(4)")
                            .font(.caption)
                    }
                    .padding(.horizontal, 5)
                    .padding(.top, -5)

                    HStack(alignment: .top, spacing: 0) {
                        WebImage(url: URL(string: course.lecture.profile_image)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 28)
                                .cornerRadius(20)
                        } placeholder: {
                            ProgressView()
                        }

                        VStack {
                            Text(course.lecture.fullName)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .padding(5)
                                .background(.ultraThickMaterial)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 10)

                        Spacer()

                        Text("\(course.type == .free ? "Free" : "Paid")")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(course.type == CourseEnrollType.free ? Color.green.gradient : Color.blue.gradient)
                            .padding(5)
                            .padding(.horizontal, 10)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    }

                    VStack {
                        if course.type == .free {
                            Text("\(course.amount + 40000) VND")
                                .font(.system(size: 14, weight: .bold))
                                .strikethrough()
                                .lineSpacing(20)
                                .foregroundColor(.mainColor1)
                        } else {
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("\(course.amount) đ")
                                    .font(.system(size: 14, weight: .bold))
                                    .lineSpacing(20)
                                    .foregroundColor(.mainColor1)
                                Text("\(course.amount + 20000) VND")
                                    .font(.system(size: 12))
                                    .lineSpacing(20)
                                    .strikethrough()
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 10)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(10)
            }

            VStack {
                Text("New")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .padding(5)
                    .padding(.horizontal, 10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .offset(x: 130, y: -130)
            }
        }
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(20)
    }
}

#Preview {
    AllFreeCoursesView()
}
