//
//  StampDetailView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct StampDetailView: View {
    @State var openPhoto = false
    @State var image: UIImage?

    var body: some View {
        VStack(spacing: 12) {
            Text("미션! 물회 먹방")
                .font(.display1)

            Text("포항특미물회")
                .font(.head1)

            Image(.물회)
                .resizable()
                .scaledToFit()
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .padding(.top, 12)

            VStack(alignment: .leading) {
                Text("주소 - 경북 포항시 북구 동빈로 106")
                Text("거리 - 2.4km")
                Text("예상 비용 - 19,000원")
            }

            Button(action: {
                openPhoto.toggle()
            }) {
                let selected = image == nil
                    ? Image(systemName: "square.and.arrow.up")
                    : Image(uiImage: image!)

                selected
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
            }

            Spacer()
        }
        .sheet(isPresented: $openPhoto) {
            UImagePicker(sourceType: .photoLibrary) { pickedImage in
                self.image = pickedImage
            }
        }
    }
}

#Preview {
    StampDetailView()
}

#Preview {
    StampDetailView()
}
