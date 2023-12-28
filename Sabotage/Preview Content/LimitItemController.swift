import UIKit

class LimitItemController: UIViewController {
    
    let dailyBudgetButton = UIButton()
    let countDownDatePicker = UIDatePicker()
    var isDatePickerVisible = false
    let timeLabel = UILabel()
    
    let dailyBudgetButton2 = UIButton()
    let countDownDatePicker2 = UIDatePicker()
    var isDatePickerVisible2 = false
    let timeLabel2 = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
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
        
        let inputName = UITextField()
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
        
        let appButton = UITextField()
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
        dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        view.addSubview(dailyBudgetButton)
        dailyBudgetButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dailyBudgetButton.topAnchor.constraint(equalTo: appButton.bottomAnchor, constant: 50),
            dailyBudgetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dailyBudgetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dailyBudgetButton.heightAnchor.constraint(equalToConstant: 60)
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
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let selectedDate = countDownDatePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)

        timeLabel.text = formattedDate
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
            self.dailyBudgetButton.heightAnchor.constraint(equalToConstant: self.isDatePickerVisible ? 200 : 60).isActive = true
            
            // Update the title label's position based on the button's height
            if self.isDatePickerVisible {
                self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -140, left: 10, bottom: 0, right: 0)
            } else {
                self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }

            self.countDownDatePicker.isHidden = !self.isDatePickerVisible
            self.view.bringSubviewToFront(self.countDownDatePicker) // 수정된 부분
            self.view.layoutIfNeeded()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !countDownDatePicker.isHidden {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.countDownDatePicker.isHidden = true
                self.dailyBudgetButton.constraints.forEach { constraint in
                    if constraint.firstAttribute == .height {
                        constraint.isActive = false
                    }
                }
                self.dailyBudgetButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
                self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
                self.view.layoutIfNeeded()
            }
        }
    }
}
