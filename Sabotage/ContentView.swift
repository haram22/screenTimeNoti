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
    func makeUIViewController(context: Context) -> UITabBarController {
        // UITabBarController 생성
        let tabBarController = UITabBarController()
        
        // 탭 바에 표시할 뷰 컨트롤러들 생성
        let mainVC = MainVC()
        let analysisVC = AnalysisVC()
        let profileVC = ProfileVC()
        
        // 각 뷰 컨트롤러에 탭 바 아이템 설정
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: nil, tag: 0)
        analysisVC.tabBarItem = UITabBarItem(title: "Analysis", image: nil, tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        // 탭 바 색상 설정
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .label
        
        // 탭 바에 뷰 컨트롤러들 추가
        tabBarController.viewControllers = [mainVC, analysisVC, profileVC]
        
        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        // 필요 시 ViewController를 업데이트하는 로직을 추가
    }
}


