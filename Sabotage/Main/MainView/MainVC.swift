//MainVC.swift

import UIKit
import SnapKit
import Then

class MainVC: UIViewController {
    var segmentedControl = UISegmentedControl()
    var actionButton = UIButton(type: .system)
    var addButton = UIButton(type: .system)
    var tabBar = UITabBar()
    
    var pieChartViewController: PieChart!
    var firstButton = UIButton(type: .system)
    var secondButton = UIButton(type: .system)
    var thirdButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        piechartUI()
        
        // 이전 화면으로 돌아가는 "< Back" 버튼 숨기기
        navigationItem.hidesBackButton = true
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // UISegmentedControl (토글) 설정
        segmentedControl.insertSegment(withTitle: "액션 아이템", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "제한 서비스", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        view.addSubview(segmentedControl)
        
        // UISegmentedControl constraints 설정
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // "액션 아이템" 추가 버튼
        actionButton.setTitle("+", for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        actionButton.layer.cornerRadius = 25 // 테두리 둥글기 설정
        actionButton.layer.borderWidth = 1 // 테두리 두께 설정
        actionButton.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        actionButton.isHidden = false // 버튼을 처음부터 보이도록 변경
    
        view.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            actionButton.widthAnchor.constraint(equalToConstant: 350),
            actionButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        // "제한 서비스" 추가 버튼
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        addButton.layer.cornerRadius = 25 // 테두리 둥글기 설정
        addButton.layer.borderWidth = 1 // 테두리 두께 설정
        addButton.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.isHidden = true // 버튼을 처음부터 보이도록 변경
        
        view.addSubview(addButton) // addButton을 뷰에 추가
                
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 350),
            addButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        tabBar.delegate = self
        view.addSubview(tabBar)
        
        // UITabBar constraints 설정
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Tab bar 내용
        let homeItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        let analysisItem = UITabBarItem(title: "Analysis", image: nil, tag: 1)
        let profileItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        // Set UITabBarItems to the UITabBar
        tabBar.setItems([homeItem, analysisItem, profileItem], animated: false)
    }
    
    func piechartUI() {
            pieChartViewController = PieChart()
            addChild(pieChartViewController)
            view.addSubview(pieChartViewController.view)
            pieChartViewController.didMove(toParent: self)

            // Buttons
            firstButton.setTitle("First", for: .normal)
            secondButton.setTitle("Second", for: .normal)
            thirdButton.setTitle("Third", for: .normal)
            
            firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
            secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
            thirdButton.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)

            [firstButton, secondButton, thirdButton].forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
            // Set constraints for the PieChart view and buttons using SnapKit
            pieChartViewController.view.snp.makeConstraints {
                $0.top.equalToSuperview().offset(30) // 10만큼 내려감
                $0.leading.trailing.equalToSuperview()
//                $0.height.equalTo(160) // 이거 땜에 에러 뜸
            }
            
            firstButton.snp.makeConstraints {
                $0.top.equalTo(pieChartViewController.view.snp.bottom).offset(-50)
                $0.leading.equalToSuperview().offset(80)
            }
            
            secondButton.snp.makeConstraints {
                $0.top.equalTo(pieChartViewController.view.snp.bottom).offset(-50)
                $0.centerX.equalToSuperview()
            }
            
            thirdButton.snp.makeConstraints {
                $0.top.equalTo(pieChartViewController.view.snp.bottom).offset(-50)
                $0.trailing.equalToSuperview().offset(-80)
            }
        }

    @objc func firstButtonTapped() {
        pieChartViewController.firstAppUI()
    }

    @objc func secondButtonTapped() {
        pieChartViewController.secondAppUI()
    }

    @objc func thirdButtonTapped() {
        pieChartViewController.thirdAppUI()
    }

    
    // 토글 선택 시 상황
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // "액션 아이템" 눌렀을 때
            actionButton.isHidden = false
            addButton.isHidden = true // 액션 아이템 선택 시 추가 버튼 숨김
        } else if sender.selectedSegmentIndex == 1 { // "제한 서비스" 눌렀을 때
            actionButton.isHidden = true
            addButton.isHidden = false // 제한 서비스 선택 시 추가 버튼 표시
        }
    }

    @objc func actionButtonTapped() {
        let actionItemController = ActionItemController()
        navigationController?.pushViewController(actionItemController, animated: true)
    }
    
    @objc func addButtonTapped() {
        let limitItemController = LimitItemController()
        navigationController?.pushViewController(limitItemController, animated: true)
    }
}

extension MainVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0, !(navigationController?.topViewController is MainVC) {
            navigationController?.popToRootViewController(animated: true)
        } else {
            switch item.tag {
            case 1:
                let analysisVC = AnalysisVC()
                navigationController?.pushViewController(analysisVC, animated: true)
            case 2:
                let profileVC = ProfileVC()
                navigationController?.pushViewController(profileVC, animated: true)
            default:
                break
            }
        }
    }
}
