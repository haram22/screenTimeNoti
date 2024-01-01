//
//  ProfileVC.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit


class ProfileVC: UIViewController {
    private let tableView = UITableView()
    private let header = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .base50
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setTableview() // Header를 추가하기 전에 테이블뷰 먼저 설정합니다.
        setHeader() // Header 추가
    }
    
    func setHeader() {
        header.backgroundColor = .white
        
        let headerlabel = UILabel()
        headerlabel.text = "즐거운스누피1441"
        headerlabel.textColor = .black
        headerlabel.textAlignment = .center
        headerlabel.font = UIFont.monospacedSystemFont(ofSize: 17, weight: .semibold)
        header.addSubview(headerlabel)
        
        
        // 이제 header를 테이블 뷰에 직접 추가합니다.
        tableView.tableHeaderView = header
        header.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 268)
        
        // 프로필 사진 백그라운드 오토레이아웃
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.heightAnchor.constraint(equalToConstant: 268)
        ])
        
        headerlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerlabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            headerlabel.centerYAnchor.constraint(equalTo: header.topAnchor, constant: 232) // 풀스크린 기준으로 위치 조정
        ])
        
        // 프로필 사진 백그라운드
        let ProfileBGView = UIImageView(image: UIImage(named: "ProfileBackground"))
        ProfileBGView.translatesAutoresizingMaskIntoConstraints = false
        ProfileBGView.contentMode = .scaleAspectFill
        
        // 프로필 사진 백그라운드 추가
        header.addSubview(ProfileBGView)
        
        // 프로필 사진 백그라운드 오토레이아웃
        NSLayoutConstraint.activate([
            ProfileBGView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            ProfileBGView.topAnchor.constraint(equalTo: header.topAnchor, constant: 108),
            ProfileBGView.widthAnchor.constraint(equalToConstant: 100),
            ProfileBGView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // 프로필 사진
        let ProfileView = UIImageView(image: UIImage(named: "Profile"))
        ProfileView.translatesAutoresizingMaskIntoConstraints = false
        ProfileView.contentMode = .scaleAspectFill
        
        // 프로필 사진 백그라운드 추가
        header.addSubview(ProfileView)
        
        // 프로필 사진 백그라운드 오토레이아웃
        NSLayoutConstraint.activate([
            ProfileView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            ProfileView.topAnchor.constraint(equalTo: header.topAnchor, constant: 121),
            ProfileView.widthAnchor.constraint(equalToConstant: 74),
            ProfileView.heightAnchor.constraint(equalToConstant: 74)
        ])
    }

    
    func setTableview() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none // 구분하는 선 없애기
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}


extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24)
        ])
        
        // 두 번째 섹션의 타이틀을 변경
        if section == 1 {
            titleLabel.text = "이용 안내"
        } else {
            titleLabel.text = "내 정보"
        }
            
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    // 각 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    // 섹션의 footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        customView.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.width - 10, height: 30))
        label.text = "wellcome to tableView footer"
        label.textAlignment = .center
        label.textColor = .white
        customView.addSubview(label)
        return customView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 // 0으로 반환하여 footer 숨김
    }
    
    // 섹션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return Model.medeling.count
    }
    
    // 각 섹션의 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.medeling[section].count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell
//        else {
//            print("fail to dequeue cell")
//            return UITableViewCell()
//        }
//        let data = Model.medeling[indexPath.section][indexPath.row]
//
//        cell.textLabel?.text = data.title
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        cell.textLabel?.frame.origin.x = 24
//        cell.layer.cornerRadius = 10
//
//        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
//        arrowIcon.tintColor = .gray
//        cell.accessoryView = arrowIcon
//
//        // ">"를 오른쪽에서 24만큼 떨어지게 위치 조정
//        if let accessoryView = cell.accessoryView {
//            accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 24
//        }
//        
//        // 두 번째 섹션의 첫 번째 행에 "설정" 타이틀 적용
//        if tableView != self.tableView && indexPath.section == 0 && indexPath.row == 0 {
//            cell.textLabel?.text = "이용 안내"
//        }
//
//        if tableView == self.tableView && indexPath.section == 0 && indexPath.row == 0 {
//            let checkmarkIcon = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
//            checkmarkIcon.tintColor = .green
//            cell.accessoryView = checkmarkIcon
//
//            if let accessoryView = cell.accessoryView {
//                accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 24
//            }
//        }
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
//        cell.addGestureRecognizer(tapGesture)
//        cell.isUserInteractionEnabled = true
//
//        return cell
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            print("fail to dequeue cell")
            return UITableViewCell()
        }
        let data = Model.medeling[indexPath.section][indexPath.row]

        cell.textLabel?.text = data.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        cell.textLabel?.frame.origin.x = 24 // 타이틀을 왼쪽으로 24만큼 이동
        cell.layer.cornerRadius = 10

        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIcon.tintColor = .gray
        cell.accessoryView = arrowIcon

        // ">"를 오른쪽에서 24만큼 떨어지게 위치 조정
        if let accessoryView = cell.accessoryView {
            accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 24
        }
        
        // 두 번째 섹션의 첫 번째 행에 "설정" 타이틀 적용
        if tableView != self.tableView && indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "이용 안내"
        }

        if tableView == self.tableView && indexPath.section == 0 && indexPath.row == 0 {
            let checkmarkIcon = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
            checkmarkIcon.tintColor = .green
            cell.accessoryView = checkmarkIcon

            if let accessoryView = cell.accessoryView {
                accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 24
            }
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        cell.addGestureRecognizer(tapGesture)
        cell.isUserInteractionEnabled = true

        return cell
    }


    
    // 셀 터치 이벤트 처리
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? UITableViewCell else { return }
        
        if let indexPath = tableView.indexPath(for: cell) {
            
            // 셀 선택 플래그를 토글하고, 색을 변경합니다.
            if let checkmarkIcon = cell.accessoryView as? UIImageView {
                if checkmarkIcon.tintColor == .green {
                    checkmarkIcon.tintColor = .gray
                } else {
                    checkmarkIcon.tintColor = .green
                }
            }
        }
    }
}

