//
//  ProfileVC.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
import SnapKit
import Then

class ProfileVC: UIViewController {
    private let tableView = UITableView()
    private let header = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .base50
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(header)
        
        setTableview()
        setHeader()
    }
    
    func setHeader() {
        header.backgroundColor = .white
        
        let headerLabel = UILabel().then {
            $0.text = "즐거운스누피1441"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.Headline()
        }
        header.addSubview(headerLabel)
        
        header.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(268)
        }
        
        headerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(header.snp.centerY).offset(84)
        }
        
        let profileBGView = UIImageView(image: UIImage(named: "ProfileBackground")).then {
            $0.contentMode = .scaleAspectFill
        }
        header.addSubview(profileBGView)
        
        profileBGView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }

        let profileView = UIImageView(image: UIImage(named: "Profile")).then {
            $0.contentMode = .scaleAspectFill
        }
        header.addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(74)
        }
    }
    
    func setTableview() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear // 이 부분을 추가해주세요.
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}




extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        
        titleLabel.font = UIFont.Subhead()
        titleLabel.textColor = .base400
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30) // 타이틀의 높이를 50포인트로 설정
        ])

        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24).isActive = true

        
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
        return nil // nil을 반환하여 footer 제거
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude // 가장 작은 높이로 설정하여 footer를 숨김
    }

    // 섹션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return Model.medeling.count
    }
    
    // 각 섹션의 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.medeling[section].count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            print("fail to dequeue cell")
            return UITableViewCell()
        }
        let data = Model.medeling[indexPath.section][indexPath.row]
        cell.textLabel?.text = data.title
        cell.textLabel?.font = UIFont.Headline()
        cell.textLabel?.frame.origin.x = 24 // 타이틀을 왼쪽으로 24만큼 이동
        cell.layer.cornerRadius = 10

        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
            arrowIcon.tintColor = .gray
            cell.accessoryView = arrowIcon
            
            // ">"를 오른쪽에서 24만큼 떨어지게 위치 조정
            if let accessoryView = cell.accessoryView {
                accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 50
                accessoryView.frame.size = CGSize(width: 10, height: 10) // 이 부분을 추가해주세요.
            }

        
        // 알림 설정 섹션의 첫 번째 행에 토글 아이콘 적용
        if tableView == self.tableView && indexPath.section == 0 && indexPath.row == 0 {
            let toggleSwitch = UISwitch() // 토글 아이콘 생성
            toggleSwitch.isOn = true // 토글을 기본으로 켜진 상태로 설정
            
            // 토글의 크기를 작게 조절
            toggleSwitch.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
            
            cell.accessoryView = toggleSwitch // 토글 아이콘으로 변경

            if let accessoryView = cell.accessoryView {
                accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // "개인정보 처리방침" 셀을 눌렀을 때만 처리
        if indexPath.section == 1 && indexPath.row == 0 {
            if let url = URL(string: "https://www.kisa.or.kr") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        // "서비스 이용약관" 셀을 눌렀을 때만 처리
        if indexPath.section == 1 && indexPath.row == 1 {
            if let url = URL(string: "https://www.kisa.or.kr") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        // "고객센터" 셀을 눌렀을 때만 처리
        if indexPath.section == 1 && indexPath.row == 2 {
            if let url = URL(string: "https://www.notion.so/young-design-archive/92730e674636406b98dbd9d474b12df9") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
