//
//  SaveActionItemController.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
import SnapKit

class AddActionItemController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // "명상" 텍스트를 보여줄 레이블 생성
        let meditationLabel = UILabel()
        meditationLabel.text = "명상"
        meditationLabel.textAlignment = .center
        meditationLabel.font = UIFont.boldSystemFont(ofSize: 24)
        meditationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(meditationLabel)
        
        // Auto Layout을 사용하여 레이블을 페이지 중앙에 위치시킴
        NSLayoutConstraint.activate([
            meditationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            meditationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // "알겠습니다" 텍스트를 보여줄 레이블 생성
        let understandLabel = UILabel()
        understandLabel.text = "해당 카테고리를 실행하기 위해"
        understandLabel.textAlignment = .center
        understandLabel.font = UIFont.systemFont(ofSize: 18)
        understandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(understandLabel)
        
        // Auto Layout을 사용하여 레이블을 "명상" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            understandLabel.topAnchor.constraint(equalTo: meditationLabel.bottomAnchor, constant: 20),
            understandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // 사용자가 입력할 수 있는 텍스트 필드 생성
        let textField = UITextField()
        textField.placeholder = "여기에 입력하세요"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 필드를 뷰에 추가
        view.addSubview(textField)
        
        // Auto Layout을 사용하여 텍스트 필드를 "알겠습니다" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: understandLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        let completeButton = UIButton(type: .system)
        completeButton.setTitle("완료", for: .normal)
        completeButton.setTitleColor(.black, for: .normal)
        completeButton.backgroundColor = .systemBlue
        completeButton.layer.cornerRadius = 15
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc func completeButtonTapped() {
        let saveActionItemController = SaveActionItemController()
        navigationController?.pushViewController(saveActionItemController, animated: true)
    }
}

