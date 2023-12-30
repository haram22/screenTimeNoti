//
//  AnalysisVC.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit

class AnalysisVC: UIViewController {
    var tabBar = UITabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        
        // MARK: - UIScrollView 생성
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // MARK: ScrollView autolayout 설정
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // MARK: - 스크롤뷰 content 추가
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        
        // MARK: - contentView의 오토레이아웃 설정
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        // MARK: - contentView에 추가할 content 생성 및 설정
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이번주"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        // MARK: - 스크롤 방향 설정
        contentView.addSubview(label)
        
        // MARK: - contentView에 추가할 content 생성 및 설정
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "랭킹"
        label2.font = .boldSystemFont(ofSize: 20)
        label2.textColor = .black
        label2.numberOfLines = 0
        contentView.addSubview(label2)
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "변화량"
        label3.font = .boldSystemFont(ofSize: 20)
        label3.textColor = .black
        label3.numberOfLines = 0
        contentView.addSubview(label3)
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "앱 별 사용량"
        label4.font = .boldSystemFont(ofSize: 20)
        label4.textColor = .black
        label4.numberOfLines = 0
        contentView.addSubview(label4)
        
        let imageView = UIImageView(image: UIImage(named: "search1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        let image2 = UIImageView(image: UIImage(named: "search2"))
        image2.translatesAutoresizingMaskIntoConstraints = false
        image2.contentMode = .scaleAspectFit
        contentView.addSubview(image2)
        
        let image3 = UIImageView(image: UIImage(named: "search3"))
        image3.translatesAutoresizingMaskIntoConstraints = false
        image3.contentMode = .scaleAspectFit
        contentView.addSubview(image3)
        
        let image4 = UIImageView(image: UIImage(named: "search4"))
        image4.translatesAutoresizingMaskIntoConstraints = false
        image4.contentMode = .scaleAspectFit
        contentView.addSubview(image4)
        
        
        // MARK: - contentView 안의 contents의 오토레이아웃 설정
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            
            label2.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 500),
            label2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                
            image2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 5),
            image2.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            image2.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            image2.heightAnchor.constraint(equalToConstant: 400),
            
            label3.topAnchor.constraint(equalTo: image2.topAnchor, constant: 500),
            label3.leadingAnchor.constraint(equalTo: image2.leadingAnchor),
            label3.trailingAnchor.constraint(equalTo: image2.trailingAnchor),
                
            image3.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 5),
            image3.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            image3.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            image3.heightAnchor.constraint(equalToConstant: 400),
            
            label4.topAnchor.constraint(equalTo: image3.topAnchor, constant: 500),
            label4.leadingAnchor.constraint(equalTo: image3.leadingAnchor),
            label4.trailingAnchor.constraint(equalTo: image3.trailingAnchor),
                
            image4.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: 5),
            image4.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            image4.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            image4.heightAnchor.constraint(equalToConstant: 400),
            image4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
        
        
        // MARK: - TabBar 설정
        tabBar.delegate = self
        view.addSubview(tabBar)
        
        // MARK: - TabBar autolayout 설정
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        
        let homeItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        let analysisItem = UITabBarItem(title: "Analysis", image: nil, tag: 1)
        let profileItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        tabBar.setItems([homeItem, analysisItem, profileItem], animated: false)
    }
    
}


extension AnalysisVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0, !(navigationController?.topViewController is MainVC) {
            navigationController?.popToRootViewController(animated: true)
        } else {
            switch item.tag {
            case 1:
                let mainVC = MainVC()
                navigationController?.pushViewController(mainVC, animated: true)
            case 2:
                let analysisVC = AnalysisVC()
                navigationController?.pushViewController(analysisVC, animated: true)
            case 3:
                let profileVC = ProfileVC()
                navigationController?.pushViewController(profileVC, animated: true)
            default:
                break
            }
        }
    }
}



