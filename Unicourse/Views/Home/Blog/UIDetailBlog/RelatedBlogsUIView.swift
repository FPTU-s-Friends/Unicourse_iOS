//
//  RelatedBlogsUIView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/6/24.
//

import SwiftUI

struct RelatedBlogsUIView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Liên quan")
                .font(.system(size: 16, weight: .bold))
                .padding(.leading, 10)

            ForEach(0 ..< 5) { _ in
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Tên tác giả")
                            .font(.system(size: 10, weight: .light))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)

                        Text("Deploy Spring Boot cùng SQL Server lên Azure, Deploy Spring Boot cùng SQL Server lên Azure, Deploy Spring Boot cùng SQL Server lên Azure")
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                    }
                    Spacer()

                    AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/unicourse-f4020.appspot.com/o/Blog%2Fblog9.png?alt=media&token=f184fcc4-48e8-4ecd-9d79-7f03a7a329f9")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)

                    } placeholder: {
                        ProgressView()
                    }
                }
                .listRowBackground(Color.mainBackgroundColor)
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    RelatedBlogsUIView()
}
