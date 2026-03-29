//
//  StampDetailView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct StampDetailView: View {
    @State private var openPhoto = false
    @State private var image: UIImage?
    @State private var reviewText: String = "리뷰를 작성해보세요!"
    
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
            
            TextEditor(text: $reviewText)
                .padding()
                .foregroundColor(Color.black)
                .font(.body2)
                .lineSpacing(5)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                .border(Color.gray, width: 1)
                .padding()
            
            Spacer()
            
            Button(action: stampButtonTapped) {
                Text("스탬프 찍기")
                    .foregroundStyle(Color.black.opacity(0.6))
                    .font(.head3)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $openPhoto) {
            UImagePicker(sourceType: .photoLibrary) { pickedImage in
                self.image = pickedImage
            }
        }
    }
    
    private func stampButtonTapped() {
        
    }
}

#Preview {
    StampDetailView()
}

#Preview {
    StampDetailView()
}
