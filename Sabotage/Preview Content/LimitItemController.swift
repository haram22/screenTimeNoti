import UIKit

class LimitItemController: UIViewController {
    
    let dailyBudgetButton = UIButton()
    let countDownDatePicker = UIDatePicker()
    var isDatePickerVisible = false
    let timeLabel = UILabel()
    
    let nudgeButton = UIButton()
    let countDownDatePicker2 = UIDatePicker()
    var isDatePickerVisible2 = false
    let timeLabel2 = UILabel()
    
    let inputName = UITextField()
    let appButton = UITextField()
    
    // 유효성 검사 경고문
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupTapGesture()
        setupTextFields()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let titleLabel = UILabel()
        titleLabel.text = "시간 제한 그룹 생성"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    
        
        inputName.placeholder = "그룹 이름"
        inputName.textColor = .black
        inputName.font = UIFont.systemFont(ofSize: 18)
        inputName.layer.cornerRadius = 15
        inputName.backgroundColor = .systemGray3
        view.addSubview(inputName)
        inputName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            inputName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputName.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // 그룹 이름 유효성 검사
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: inputName.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: inputName.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: inputName.trailingAnchor)
        ])
        
        appButton.placeholder = "App"
        appButton.textColor = .black
        appButton.font = UIFont.systemFont(ofSize: 18)
        appButton.layer.cornerRadius = 15
        appButton.backgroundColor = .systemGray3
        view.addSubview(appButton)
        appButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appButton.topAnchor.constraint(equalTo: inputName.bottomAnchor, constant: 50),
            appButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            appButton.heightAnchor.constraint(equalToConstant: 60)
        ])
                
        // 앱 하루 총 사용 시간 버튼
        dailyBudgetButton.setTitle("하루 총 사용 시간", for: .normal)
        dailyBudgetButton.setTitleColor(.systemGray, for: .normal)
        dailyBudgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        dailyBudgetButton.contentHorizontalAlignment = .left
        dailyBudgetButton.layer.cornerRadius = 15
        dailyBudgetButton.backgroundColor = .systemGray3
        dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -50, left: 5, bottom: 0, right: 50)
        view.addSubview(dailyBudgetButton)
        dailyBudgetButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dailyBudgetButton.topAnchor.constraint(equalTo: appButton.bottomAnchor, constant: 50),
            dailyBudgetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dailyBudgetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dailyBudgetButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        dailyBudgetButton.addTarget(self, action: #selector(dailyBudgetButtonTapped), for: .touchUpInside)
        
        // 앱 하루 총 사용 시간 설정
        countDownDatePicker.datePickerMode = .countDownTimer
        countDownDatePicker.backgroundColor = .systemGray3
        countDownDatePicker.isHidden = true
        view.addSubview(countDownDatePicker)
        countDownDatePicker.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            countDownDatePicker.topAnchor.constraint(equalTo: dailyBudgetButton.topAnchor, constant: 50),
            countDownDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            countDownDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            countDownDatePicker.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        countDownDatePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        
        // countDownDatePicker에서 설정한 시간
        view.addSubview(timeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        timeLabel.centerYAnchor.constraint(equalTo: dailyBudgetButton.centerYAnchor),
        timeLabel.topAnchor.constraint(equalTo: dailyBudgetButton.topAnchor, constant: 0),
        timeLabel.trailingAnchor.constraint(equalTo: dailyBudgetButton.trailingAnchor, constant: -20)
        ])
        
        timeLabel.textColor = .black
        timeLabel.isHidden = true
        
        let infoLabel = UILabel()
        infoLabel.text = "하루에 앱을 얼마나 사용할지 총 목표 시간을 설정해주세요"
        infoLabel.textColor = .systemGray
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textAlignment = .left
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: dailyBudgetButton.bottomAnchor, constant: 5),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        // ================== 앱 알람 간격 설정 ==================
        
        nudgeButton.setTitle("앱 알람 간격 설정", for: .normal)
        nudgeButton.setTitleColor(.systemGray, for: .normal)
        nudgeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        nudgeButton.contentHorizontalAlignment = .left
        nudgeButton.layer.cornerRadius = 15
        nudgeButton.backgroundColor = .systemGray3
        nudgeButton.titleEdgeInsets = UIEdgeInsets(top: -50, left: 5, bottom: 0, right: 50)
        view.addSubview(nudgeButton)
        nudgeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nudgeButton.topAnchor.constraint(equalTo: dailyBudgetButton.bottomAnchor, constant: 50),
            nudgeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nudgeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nudgeButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        nudgeButton.addTarget(self, action: #selector(nudgeButtonTapped), for: .touchUpInside)
        
        // 앱 하루 총 사용 시간 설정
        countDownDatePicker2.datePickerMode = .countDownTimer
        countDownDatePicker2.backgroundColor = .systemGray3
        countDownDatePicker2.isHidden = true
        view.addSubview(countDownDatePicker2)
        countDownDatePicker2.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            countDownDatePicker2.topAnchor.constraint(equalTo: nudgeButton.topAnchor, constant: 50),
            countDownDatePicker2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            countDownDatePicker2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            countDownDatePicker2.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        countDownDatePicker2.addTarget(self, action: #selector(datePickerValueChanged2), for: .valueChanged)
        
        // countDownDatePicker에서 설정한 시간
        view.addSubview(timeLabel2)
        
        timeLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        timeLabel2.centerYAnchor.constraint(equalTo: nudgeButton.centerYAnchor),
        timeLabel2.topAnchor.constraint(equalTo: nudgeButton.topAnchor, constant: 0),
        timeLabel2.trailingAnchor.constraint(equalTo: nudgeButton.trailingAnchor, constant: -20)
        ])
        
        timeLabel2.textColor = .black
        timeLabel2.isHidden = true
        
        let nudgeInfoLabel = UILabel()
        nudgeInfoLabel.text = "무한 스크롤링에서 벗어나 앱을 탈출할 신호를 보내줄게요!알람 간격을 설정해주세요!"
        nudgeInfoLabel.textColor = .systemGray
        nudgeInfoLabel.font = UIFont.systemFont(ofSize: 14)
        nudgeInfoLabel.textAlignment = .left
        nudgeInfoLabel.numberOfLines = 0
        nudgeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nudgeInfoLabel)
        
        NSLayoutConstraint.activate([
            nudgeInfoLabel.topAnchor.constraint(equalTo: nudgeButton.bottomAnchor, constant: 5),
            nudgeInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            nudgeInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
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
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            completeButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    // dailyBudgetButton을 탭할 때 datePicker 표시/숨김 토글
    @objc func showHideDatePicker() {
        countDownDatePicker.isHidden = !countDownDatePicker.isHidden
    }
    
    // 다른 곳을 탭했을 때 datePicker 숨기기
    @objc func dismissDatePicker(sender: UITapGestureRecognizer) {
        if !countDownDatePicker.isHidden {
            let touchLocation = sender.location(in: self.view)
            if !countDownDatePicker.frame.contains(touchLocation) {
                countDownDatePicker.isHidden = true
            }
        }
    }
    
    // 앱 하루 총 사용 시간
    @objc func datePickerValueChanged() {
        let selectedDate = countDownDatePicker.date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedDate)
        
        if let hour = components.hour, let minute = components.minute {
            let formattedHour = String(format: "%02d", hour)
            let formattedMinute = String(format: "%02d", minute)
            
            timeLabel.text = "\(formattedHour) hours \(formattedMinute) min"
        }
    }
    
    @objc func dailyBudgetButtonTapped() {
        isDatePickerVisible.toggle()

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            // Update the visibility of the label with the selected time
            self.timeLabel.isHidden = !self.isDatePickerVisible
            
            // Update the button's height constraint
            self.dailyBudgetButton.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.isActive = false
                }
            }
            self.dailyBudgetButton.heightAnchor.constraint(equalToConstant: self.isDatePickerVisible ? 200 : 100).isActive = true
            
            // Update the title label's position based on the button's height
            if self.isDatePickerVisible {
                self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -140, left: 10, bottom: 0, right: 0)
            } else {
                self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -50, left: 10, bottom: 0, right: 0)
            }

            self.countDownDatePicker.isHidden = !self.isDatePickerVisible
            self.view.bringSubviewToFront(self.countDownDatePicker) // 수정된 부분
            self.view.layoutIfNeeded()
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.view)

        // Check if countDownDatePicker2 is visible and touch location is outside of it
        if !countDownDatePicker2.isHidden, let loc = location, !countDownDatePicker2.frame.contains(loc) {
            hideCountDownDatePicker2()
        }

        // If countDownDatePicker is visible, handle its logic
        if !countDownDatePicker.isHidden {
            hideCountDownDatePicker()
        }
    }

    func hideCountDownDatePicker() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.countDownDatePicker.isHidden = true
            self.dailyBudgetButton.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.isActive = false
                }
            }
            self.dailyBudgetButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -50, left: 10, bottom: 0, right: 50)
            self.view.layoutIfNeeded()
        }
    }
    
    func hideCountDownDatePicker2() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.countDownDatePicker2.isHidden = true
            self.nudgeButton.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.isActive = false
                }
            }
            self.nudgeButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self.nudgeButton.titleEdgeInsets = UIEdgeInsets(top: -50, left: 10, bottom: 0, right: 50)
            self.view.layoutIfNeeded()
        }
    }

    
    // ==================================
    
    @objc func nudgeButtonTapped() {
        isDatePickerVisible.toggle()

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            // Update the visibility of the label with the selected time
            self.timeLabel2.isHidden = !self.isDatePickerVisible
            
            // Update the button's height constraint
            self.nudgeButton.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.isActive = false
                }
            }
            self.nudgeButton.heightAnchor.constraint(equalToConstant: self.isDatePickerVisible ? 200 : 100).isActive = true
            
            // Update the title label's position based on the button's height
            if self.isDatePickerVisible {
                self.nudgeButton.titleEdgeInsets = UIEdgeInsets(top: -140, left: 10, bottom: 0, right: 0)
            } else {
                self.nudgeButton.titleEdgeInsets = UIEdgeInsets(top: -50, left: 10, bottom: 0, right: 0)
            }

            self.countDownDatePicker2.isHidden = !self.isDatePickerVisible
            self.view.bringSubviewToFront(self.countDownDatePicker2)
            self.view.layoutIfNeeded()
        }
        
    }
    
    // 앱 알람 간격 시간
    @objc func datePickerValueChanged2() {
        let selectedDate = countDownDatePicker2.date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedDate)
        
        if let hour = components.hour, let minute = components.minute {
            let formattedHour = String(format: "%02d", hour)
            let formattedMinute = String(format: "%02d", minute)
            
            timeLabel2.text = "\(formattedHour) hours \(formattedMinute) min"
        }
    }
    
    // "완료" 버튼 클릭 시
    @objc func completeButtonTapped() {
        // Check if inputName meets the character limit
        if let text = inputName.text, !text.isEmpty, text.count <= 10 {
            // If it's within the limit, proceed to the MainVC
            let completeActionItemController = MainVC()
            navigationController?.pushViewController(completeActionItemController, animated: true)
            // Hide the error label if validation passes
            errorLabel.isHidden = true
        } else {
            // If it exceeds the limit, show an error message and display the error label
            errorLabel.text = "10자 이내로 작성해주세요"
            errorLabel.isHidden = false
        }
    }
}

extension LimitItemController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LimitItemController {
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupTextFields() {
        inputName.delegate = self
        appButton.delegate = self
    }
}
