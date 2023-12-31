import UIKit
import FamilyControls
import SwiftUI
import SnapKit
import Then

class LimitItemController: UIViewController, UIGestureRecognizerDelegate {
    var isDatePickerVisible = false
    var isDatePickerVisible2 = false
    let dailyBudgetButton = UIButton()
    let countDownDatePicker = UIDatePicker()
    let infoLabel = UILabel()
    let timeLabel = UILabel()
    let titleLabel = UILabel()
    let nudgeButton = UIButton()
    let countDownDatePicker2 = UIDatePicker()
    let timeLabel2 = UILabel()
    let nudgeInfoLabel = UILabel()
    let inputName = UITextField()
    let errorLabel = UILabel()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setUp()
        setupTapGesture()
        setupTextFields()
    }
    
    func setUp(){
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        // MARK: - SwiftUi 사용을 위한 코드
        let detailView = DetailView()
        let selectedApps = detailView.$selection.applicationTokens
        let hostingController = UIHostingController(rootView: detailView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // MARK: - custom backbutton을 위한 코드
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        titleLabel.then {
            $0.text = "시간 제한 그룹 생성"
            $0.textAlignment = .center
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            view.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        inputName.then {
            $0.placeholder = "그룹 이름"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .systemGray3
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        
        errorLabel.then {
            $0.textColor = .red
            $0.textAlignment = .left
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalTo(inputName.snp.bottom).offset(8)
            make.leading.equalTo(inputName.snp.leading)
            make.trailing.equalTo(inputName.snp.trailing)
        }
        // MARK: - SwiftUi 코드
        hostingController.view.then {
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
        
        dailyBudgetButton.then {
            $0.setTitle("하루 총 사용 시간", for: .normal)
            $0.setTitleColor(.systemGray, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            $0.contentHorizontalAlignment = .left
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .systemGray3
            $0.titleEdgeInsets = UIEdgeInsets(top: -70, left: 10, bottom: 0, right: 50)
            $0.addTarget(self, action: #selector(dailyBudgetButtonTapped), for: .touchUpInside)
            contentView.addSubview($0)
        }.snp.makeConstraints {
            $0.top.equalTo(hostingController.view.snp.bottom).offset(-580)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(100)
        }
        
        countDownDatePicker.then {
            $0.datePickerMode = .countDownTimer
            $0.backgroundColor = .systemGray3
            $0.isHidden = true
            contentView.addSubview($0)
            $0.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        }.snp.makeConstraints { make in
            make.top.equalTo(dailyBudgetButton.snp.top).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(120)
        }
        
        timeLabel.then {
            $0.textColor = .black
            $0.isHidden = true
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.centerY.equalTo(dailyBudgetButton.snp.centerY).offset(-70)
            make.top.equalTo(dailyBudgetButton.snp.top)
            make.trailing.equalTo(dailyBudgetButton.snp.trailing).inset(20)
        }
        
        infoLabel.then {
            $0.text = "하루에 앱을 얼마나 사용할지 총 목표 시간을 설정해주세요"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalTo(dailyBudgetButton.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(35)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
        
        nudgeButton.then {
            $0.setTitle("앱 알람 간격 설정", for: .normal)
            $0.setTitleColor(.systemGray, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            $0.contentHorizontalAlignment = .left
            $0.layer.cornerRadius = 15
            $0.backgroundColor = .systemGray3
            $0.titleEdgeInsets = UIEdgeInsets(top: -70, left: 10, bottom: 0, right: 50)
            $0.addTarget(self, action: #selector(nudgeButtonTapped), for: .touchUpInside)
            contentView.addSubview($0)
        }.snp.makeConstraints {
            $0.top.equalTo(dailyBudgetButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(100)
        }
        
        countDownDatePicker2.then {
            $0.datePickerMode = .countDownTimer
            $0.backgroundColor = .systemGray3
            $0.isHidden = true
            $0.addTarget(self, action: #selector(datePickerValueChanged2), for: .valueChanged)
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalTo(nudgeButton.snp.top).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(120)
        }
        
        timeLabel2.then {
            $0.textColor = .black
            $0.isHidden = true
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.centerY.equalTo(nudgeButton.snp.centerY).offset(-70)
            make.top.equalTo(nudgeButton.snp.top)
            make.trailing.equalTo(nudgeButton.snp.trailing).inset(20)
        }
        
        nudgeInfoLabel.then {
            $0.text = "무한 스크롤링에서 벗어나 앱을 탈출할 신호를 보내줄게요! 알람 간격을 설정해주세요!"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = .left
            $0.numberOfLines = 0
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.top.equalTo(nudgeButton.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(35)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
        
        let completeButton = UIButton(type: .system)
        completeButton.then {
            $0.setTitle("완료", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = 15
            $0.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
            contentView.addSubview($0)
        }.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.height.equalTo(70)
        }
        
    }
    
    // dailyBudgetButton을 탭할 때 datePicker 표시/숨김 토글
//    @objc func showHideDatePicker() {
//        countDownDatePicker.isHidden = !countDownDatePicker.isHidden
//    }

    
    // 앱 하루 총 사용 시간
    @objc func datePickerValueChanged() {
        let selectedDate = countDownDatePicker.date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedDate)
        
        if let hour = components.hour, let minute = components.minute {
            let formattedHour = String(format: "%02d", hour)
            let formattedMinute = String(format: "%02d", minute)
            
            timeLabel.text = "\(formattedHour) hours \(formattedMinute) min"
            print("🤗 \(formattedHour) hours \(formattedMinute) min")
            
        }
    }
    
    @objc func dailyBudgetButtonTapped() {
        print("tapped dailyBudgetButton")
        isDatePickerVisible.toggle()
        print("toggle in dailyBudgetButtonTapped()")
        
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
                self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -70, left: 10, bottom: 0, right: 0)
            }
            
            self.countDownDatePicker.isHidden = !self.isDatePickerVisible
            self.view.bringSubviewToFront(self.countDownDatePicker) // 수정된 부분
            self.view.layoutIfNeeded()
        }
    }
    
    func hideCountDownDatePicker() {
        print("countDownDatePicker 끄러 옴.")
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.countDownDatePicker.isHidden = true
            self.dailyBudgetButton.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.isActive = false
                }
            }
            self.dailyBudgetButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self.dailyBudgetButton.titleEdgeInsets = UIEdgeInsets(top: -70, left: 10, bottom: 0, right: 50)
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
        if let text = inputName.text, !text.isEmpty, text.count <= 3 {
            // If it's within the limit, proceed to the MainVC
            let completeActionItemController = MainVC()
            navigationController?.pushViewController(completeActionItemController, animated: true)
            // Hide the error label if validation passes
            errorLabel.isHidden = true
            limitPostRequest(with: 1, title: "title", apps: ["a", "b"], timeBudget: 2)
        } else {
            // If it exceeds the limit, show an error message and display the error label
            errorLabel.text = "3자 이내로 작성해주세요"
            errorLabel.isHidden = false
        }
        print("그룹 이름 : \(String(describing: inputName.text))")
        print("제한 중인 앱 : \(FamilyActivitySelection().applications)")
        print("하루 총 사용 시간 : \(timeLabel.text)")
        print("앱 알람 간격 설정 : \(timeLabel2.text)")
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
        
        print("setupTapGesture")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissPicker(_ gestureRecognizer: UITapGestureRecognizer) {
        print("dismissPicker")
        let touchLocation = gestureRecognizer.location(in: view)
        
        if !countDownDatePicker.isHidden && !countDownDatePicker.frame.contains(touchLocation) {
            hideCountDownDatePicker()
        }

        if !countDownDatePicker2.isHidden && !countDownDatePicker2.frame.contains(touchLocation) {
            hideCountDownDatePicker2()
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("gestureRecognizer")
        let touchLocation = touch.location(in: view)

        if !countDownDatePicker.isHidden && countDownDatePicker.frame.contains(touchLocation) {
//            print("toggle in gestureRecognizer")
//            isDatePickerVisible.toggle()
            return false
        }

        if !countDownDatePicker2.isHidden && countDownDatePicker2.frame.contains(touchLocation) {
//            isDatePickerVisible.toggle()
            return false
        }

        return true
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupTextFields() {
        inputName.delegate = self
    }
}

