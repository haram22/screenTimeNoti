//MainVC.swift - 메인 페이지

import UIKit
import SwiftUI
import SnapKit
import Then

protocol LimitItemDelegate: AnyObject {
    func addNewLimitItem(_ itemName: String)
}

class MainVC: UIViewController, LimitItemDelegate, ActionItemDelegate{

    var segmentedControl = UISegmentedControl()
    var actionButton = UIButton(type: .system)
    var limitButton = UIButton(type: .system)
    var addButton = UIButton(type: .system)
    var tabBar = UITabBar()
    
    var pieChartViewController: PieChart!
    var firstButton = UIButton(type: .system)
    var secondButton = UIButton(type: .system)
    var thirdButton = UIButton(type: .system)
    
    var limitTableView: UITableView!
    var actionTableView: UITableView!
    
    var limitItems: [LimitDummyDataType] = [
        LimitDummyDataType(title: "제한그룹 1", description: "제한그룹 1임다"),
        LimitDummyDataType(title: "제한그룹 2", description: "제한그룹 2임다"),
        LimitDummyDataType(title: "제한그룹 3", description: "제한그룹 3임다")
    ]
    var actionItems: [ActionDummyDataType] = [
        ActionDummyDataType(title: "액션 1", description: "액션 1에 대한 설명입니다."),
        ActionDummyDataType(title: "액션 2", description: "액션 1에 대한 설명입니다.")
    ]


    // tableview data
    // LimitItemDelegate 메서드 구현
    func addNewLimitItem(_ itemName: String) {
        // LimitItemController에서 전달된 itemName을 기존 데이터에 추가
        let newLimitItem = LimitDummyDataType(title: itemName, description: "새로운 항목 설명")
        limitItems.append(newLimitItem)

        // TableView 업데이트
        limitTableView.reloadData()
    }
    
    // tableview data
//    func didAddActionItemText(_ text: String) {
//        print("AddActionItemController에서 받은 데이터: \(text)")
//        let newActionItem = ActionDummyDataType(title: text, description: "새로운 항목 설명")
//        actionItems.append(newActionItem)
//        actionTableView.reloadData()
//    }
    func didAddActionItemText(_ text: String) {
        // Handle the received text here and update your table view data source
        // For example, add it to your actionItems array and then reload the table view
        let newActionItem = ActionDummyDataType(title: text, description: "New Description")
        actionItems.append(newActionItem)
        actionTableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        limitTableView = UITableView(frame: .zero, style: .plain)
        actionTableView = UITableView(frame: .zero, style: .plain)

        
        // 뷰에 테이블뷰 추가
        view.addSubview(limitTableView)
        view.addSubview(actionTableView)

        // Auto Layout을 위한 설정
        limitTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            limitTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            limitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            limitTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            limitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Auto Layout을 위한 설정
        actionTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
            actionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    
        actionTableView = UITableView(frame: .zero, style: .plain)
        configureTableView(actionTableView, cellClass: ActionTableViewCell.self, identifier: "ActionCustomCell")
                
        // limitTableView 설정
        limitTableView = UITableView(frame: .zero, style: .plain)
        configureTableView(limitTableView, cellClass: LimitTableViewCell.self, identifier: "LimitCustomCell")
                
        // 초기에는 actionTableView만 보이도록 설정
        actionTableView.isHidden = false
        limitTableView.isHidden = true
        
        func setupTableView1(_ tableView: UITableView, items: [ActionDummyDataType], identifier: String) {
                view.addSubview(tableView)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])

                tableView.dataSource = self
                tableView.delegate = self
                tableView.register(ActionTableViewCell.self, forCellReuseIdentifier: identifier)
            }
        
        func setupTableView(_ tableView: UITableView, items: [LimitDummyDataType], identifier: String) {
                view.addSubview(tableView)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])

                tableView.dataSource = self
                tableView.delegate = self
                tableView.register(LimitTableViewCell.self, forCellReuseIdentifier: identifier)
            }
        
        
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
        // MARK: - 디자인때 필요할 것 같아서 남겨뒀움
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
            actionButton.topAnchor.constraint(equalTo: actionTableView.bottomAnchor, constant: -80),
            actionButton.widthAnchor.constraint(equalToConstant: 350),
            actionButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        limitButton.setTitle("+", for: .normal)
        limitButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        limitButton.layer.cornerRadius = 25 // 테두리 둥글기 설정
        limitButton.layer.borderWidth = 1 // 테두리 두께 설정
        limitButton.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
        limitButton.addTarget(self, action: #selector(limitButtonTapped), for: .touchUpInside)
        limitButton.isHidden = true // 버튼을 처음부터 보이도록 변경

        view.addSubview(limitButton)

        limitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            limitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            limitButton.topAnchor.constraint(equalTo: limitTableView.bottomAnchor, constant: -80),
            limitButton.widthAnchor.constraint(equalToConstant: 350),
            limitButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
       
    }

    private func configureTableView(_ tableView: UITableView, cellClass: UITableViewCell.Type, identifier: String) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500), // 수정됨
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
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
        if sender.selectedSegmentIndex == 0 {
            // Show actionButton and hide limitButton
            actionButton.isHidden = false
            limitButton.isHidden = true
            actionTableView.isHidden = false
            limitTableView.isHidden = true
        } else {
            // Hide actionButton and show limitButton
            actionButton.isHidden = true
            limitButton.isHidden = false
            actionTableView.isHidden = true
            limitTableView.isHidden = false
        }
    }

    
    @objc func actionButtonTapped() {
        let actionItemController = ActionItemController()
        actionItemController.delegate = self // Set MainVC as the delegate for ActionItemController
        navigationController?.pushViewController(actionItemController, animated: true)

//         let monitoringView = MonitoringView()

        // SwiftUI 뷰를 호스팅하는 UIHostingController 생성
//        let hostingController = UIHostingController(rootView: monitoringView)
//
////         actionPostRequest(with: 0, title: "title", apps: ["String", "string2"], timeBudget: 0)
//
//        // 네비게이션 컨트롤러를 사용하여 화면 전환
//        navigationController?.pushViewController(hostingController, animated: true)

//        //MARK: 서윤 - saveactionitem 확인
//        let saveActionItemController = SaveActionItemController()
//        navigationController?.pushViewController(saveActionItemController, animated: true)
    }

    
    @objc func limitButtonTapped() {
//        let limitItemController = LimitItemController()
//        navigationController?.pushViewController(limitItemController, animated: true)
//         MARK: - ram test code
               print("addButtonTapped")
               // SwiftUI 뷰 인스턴스 생성
               let scheduleView = ScheduleView()
      
               // SwiftUI 뷰를 호스팅하는 UIHostingController 생성
               let hostingController = UIHostingController(rootView: scheduleView)
      
      //          네비게이션 컨트롤러를 사용하여 화면 전환
               navigationController?.pushViewController(hostingController, animated: true)
        
    }


    // LimitItemController로 이동하는 액션 메서드
    @objc func addButtonTapped() {

        let limitItemController = LimitItemController()
        limitItemController.delegate = self // LimitItemDelegate 설정
        navigationController?.pushViewController(limitItemController, animated: true)


//        // MARK: - ram test code
//         print("addButtonTapped")
//         // SwiftUI 뷰 인스턴스 생성
//         let scheduleView = ScheduleView()
//
//         // SwiftUI 뷰를 호스팅하는 UIHostingController 생성
//         let hostingController = UIHostingController(rootView: scheduleView)
//
////          네비게이션 컨트롤러를 사용하여 화면 전환
//         navigationController?.pushViewController(hostingController, animated: true)

    }

//    func didAddActionItemText(_ text: String) {
//    }
    
    func didActionItemText(_ text: String) {
    }


}
