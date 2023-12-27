//ContentView

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        // SwiftUI NavigationView 안에 UIKit 기반의 MainVC를 호스팅
        NavigationView {
            MainVCRepresentable()
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true) // 네비게이션 바 숨김
        }
    }
}

struct MainVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        // UINavigationController를 생성하여 MainVC를 넣음
        let navigationController = UINavigationController(rootViewController: MainVC())
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // 필요 시 ViewController를 업데이트하는 로직을 추가
    }
}
