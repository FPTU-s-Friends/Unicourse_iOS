//
//  PageView.swift
//  Unicourse
//
//  Created by Trung Kiên Nguyễn on 2/5/24.
//

import SwiftUI

struct PageView: View {
    var page: OnboardModel
    @State private var isBreathing = false

    var body: some View {
        VStack(spacing: 10) {
            Image("\(page.imageUrl)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: imageHeight(for: page.tag))
                .cornerRadius(10)
                .padding(paddingInsets(for: page.tag))
                .scaleEffect(scaleFactor(for: page.tag))
                .animation(Animation.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: isBreathing)
                .onAppear {
                    isBreathing = true
                }

            Text(page.name)
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.black)

            Text(page.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 300, height: 60)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            Spacer()
        }
        .ignoresSafeArea()
    }

    private func imageHeight(for tag: Int) -> CGFloat {
        switch tag {
        case 0:
            return 570
        case 2:
            return 750
        default:
            return 580
        }
    }

    private func paddingInsets(for tag: Int) -> EdgeInsets {
        switch tag {
        case 2:
            return EdgeInsets(top: 30, leading: 2, bottom: -220, trailing: 0)
        default:
            return EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0)
        }
    }

    private func scaleFactor(for tag: Int) -> CGFloat {
        switch tag {
        case 0:
            return isBreathing ? 1.2 : 1.0
        case 2:
            return isBreathing ? 1.1 : 1.0
        default:
            return isBreathing ? 1.1 : 1.0
        }
    }
}

#Preview {
    PageView(page: OnboardModel.pageBanners[0])
}
