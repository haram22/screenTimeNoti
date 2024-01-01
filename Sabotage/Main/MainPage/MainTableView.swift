//
//  MainTableView.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import Foundation
import UIKit
import SnapKit
import Then

//extension MainVC: UITabBarDelegate {
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.tag == 0, !(navigationController?.topViewController is MainVC) {
//            navigationController?.popToRootViewController(animated: true)
//        } else {
//            switch item.tag {
//            case 1:
//                let analysisVC = AnalysisVC()
//                navigationController?.pushViewController(analysisVC, animated: true)
//            case 2:
//                let profileVC = ProfileVC()
//                navigationController?.pushViewController(profileVC, animated: true)
//            default:
//                break
//            }
//        }
//    }
//}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableView == actionTableView {
                return actionItems.count
            } 
            else if tableView == limitTableView {
                return limitItems.count
            }
            return 0
        }
    
    
    func addNewItem(item: LimitDummyDataType) {
            // 데이터 소스 업데이트
            limitItems.append(item)

            // 테이블 뷰에 새로운 셀 추가
            let newIndexPath = IndexPath(row: limitItems.count - 1, section: 0)
            limitTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    
    func addNewActionItem(item: ActionDummyDataType) { // 'limit' -> 'action'
            // 데이터 소스 업데이트
            actionItems.append(item) // 'limit' -> 'action'

            // 테이블 뷰에 새로운 셀 추가
            let newIndexPath = IndexPath(row: actionItems.count - 1, section: 0) // 'limit' -> 'action'
            actionTableView.insertRows(at: [newIndexPath], with: .automatic) // 'limit' -> 'action'
        }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 셀 선택 시 처리
//        print("\(indexPath.row) 선택")
//    }
    
    // 셀을 선택했을 때의 동작
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if tableView == actionTableView {
                // ActionTableView에서 셀을 선택한 경우 동작 정의
                print("ActionTableView의 \(indexPath.row) 번째 셀 선택됨")
            } else if tableView == limitTableView {
                // LimitTableView에서 셀을 선택한 경우 동작 정의
                print("LimitTableView의 \(indexPath.row) 번째 셀 선택됨")
            }
        }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == actionTableView {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCustomCell", for: indexPath) as? ActionTableViewCell else {
//                return UITableViewCell()
//            }
//            let item = actionItems[indexPath.row]
//            // Action 데이터에 따라 cell 구성
//            cell.titleLabel.text = item.title
//            cell.descriptionLabel.text = item.description
//            return cell
//        } else if tableView == limitTableView {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LimitCustomCell", for: indexPath) as? LimitTableViewCell else {
//                return UITableViewCell()
//            }
//            let item = limitItems[indexPath.row]
//            // Limit 데이터에 따라 cell 구성
//            cell.titleLabel.text = item.title
//            cell.descriptionLabel.text = item.description
//            return cell
//        }
//        return UITableViewCell()
//    }
    
    // 각 셀에 대한 설정
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if tableView == actionTableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCustomCell", for: indexPath) as! ActionTableViewCell
                let item = actionItems[indexPath.row]
                cell.titleLabel.text = item.title
                cell.descriptionLabel.text = item.description
                return cell
            } else if tableView == limitTableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LimitCustomCell", for: indexPath) as! LimitTableViewCell
                let item = limitItems[indexPath.row]
                cell.titleLabel.text = item.title
                cell.descriptionLabel.text = item.description
                return cell
            }
            return UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 50 // 푸터 높이, 필요에 따라 조정
        }

        // 섹션 푸터 뷰 설정
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear

        let addButton = UIButton(type: .system)

        // limitTableView와 actionTableView에 대한 분기 처리
        if tableView == limitTableView {
            addButton.setTitle("Limit 추가", for: .normal)
            addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        } else if tableView == actionTableView {
            addButton.setTitle("Action 추가", for: .normal)
            addButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        }

        footerView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])

        return footerView
    }

        // MARK: - 데이터 전달 후 셀 추가를 위한 함수.
        @objc func addCellButtonTapped() {
            // 버튼 탭 시 실행될 액션
            // 예: 새로운 데이터 항목 추가 등
        }
}
