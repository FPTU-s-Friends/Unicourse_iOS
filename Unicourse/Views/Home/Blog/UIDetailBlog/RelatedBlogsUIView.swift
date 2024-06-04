//
//  RelatedBlogsUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

struct RelatedBlogsUIView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var listRelatedBlog: [BlogModel]

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.activeColor)
                .frame(height: 4)

            Text("Liên quan")
                .font(.system(size: 16, weight: .bold))
                .padding(.leading, 10)

            ForEach(listRelatedBlog, id: \._id) { blog in
                HStack(alignment: .top) {
                    NavigationLink(destination: DetailBlogView(blogId: blog._id)) {
                        VStack(alignment: .leading) {
                            Text(blog.userId.fullName)
                                .font(.system(size: 10, weight: .light))
                                .foregroundStyle(Color.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)

                            Text(blog.title)
                                .font(.system(size: 12, weight: .semibold))
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                                .lineLimit(3)
                        }
                        Spacer()

                        AsyncImage(url: URL(string: blog.thumbnail_url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)

                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .listRowBackground(Color.mainBackgroundColor)

                Rectangle()
                    .fill(Color.mainColor3)
                    .frame(width: 300, height: 2)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    RelatedBlogsUIView(listRelatedBlog: [BlogModel.sampleBlogModel])
}
