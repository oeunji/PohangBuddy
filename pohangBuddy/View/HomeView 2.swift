import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("logo")
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 10)
            .padding(.bottom, 24)

            HStack {
                DropDownView()
                Spacer()
            }
            .padding(.horizontal, 24)

            Image("map")
                .resizable()
                .scaledToFit()
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .padding(.top, 12)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("스탬프 현황")
                        .font(.head2)
                    Text("10개 중 4개 채웠어요!")
                        .font(.body1)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)

            StampStatusView()
                .padding(.horizontal, 24)
                .padding(.top, 16)

            Spacer()

            Button(action: fishCareButtonTapped) {
                Text("밥 주러 가기")
                    .foregroundStyle(Color.black.opacity(0.6))
                    .font(.head3)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .sheet(isPresented: self.$showModal) {
                FishCareView()
            }
        }
    }

    private func fishCareButtonTapped() {
        self.showModal = true
    }
}