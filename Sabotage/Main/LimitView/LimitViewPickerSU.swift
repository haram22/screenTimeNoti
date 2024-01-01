//
//  LimitViewPickerSU.swift
//  Sabotage
//
//  Created by 김하람 on 1/1/24.
//

import Foundation
import SwiftUI

struct CustomPicker: UIViewRepresentable {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    let hours = Array(0...23)
    let minutes = Array(0...59)

    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        return picker
    }

    func updateUIView(_ uiView: UIPickerView, context: Context) {
        uiView.selectRow(hours.firstIndex(of: selectedHour) ?? 0, inComponent: 0, animated: true)
        uiView.selectRow(minutes.firstIndex(of: selectedMinute) ?? 0, inComponent: 1, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: CustomPicker

        init(_ pickerView: CustomPicker) {
            self.parent = pickerView
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            2 // 시간과 분을 위한 두 개의 컴포넌트
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0 { // 첫 번째 컴포넌트(시간)
                return parent.hours.count
            } else { // 두 번째 컴포넌트(분)
                return parent.minutes.count
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = view as? UILabel ?? UILabel()
            label.textAlignment = .center
            label.textColor = .black // 라벨의 텍스트 색상을 설정합니다.
            
            // 컴포넌트에 따라 라벨에 텍스트를 설정합니다.
            if component == 0 {
                label.text = "\(parent.hours[row])"
            } else {
                label.text = "\(parent.minutes[row])"
            }

            // 배경색을 현재 선택된 행에 맞게 설정합니다.
            if row == pickerView.selectedRow(inComponent: component) {
                label.backgroundColor = .green // 선택된 행에 대한 배경색
            } else {
                label.backgroundColor = .clear // 선택되지 않은 행에 대한 배경색
            }

            return label
        }




        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickerView.reloadAllComponents() // 모든 컴포넌트를 새로 고칩니다.

            if component == 0 {
                parent.selectedHour = parent.hours[row]
            } else {
                parent.selectedMinute = parent.minutes[row]
            }
        }
    }
}


//countDownDatePicker.then {
//    $0.datePickerMode = .countDownTimer
//    $0.backgroundColor = .systemGray3
//    $0.isHidden = true
//    contentView.addSubview($0)
//    $0.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
//}.snp.makeConstraints { make in
//    make.top.equalTo(dailyBudgetButton.snp.top).offset(50)
//    make.leading.equalToSuperview().offset(30)
//    make.trailing.equalToSuperview().inset(30)
//    make.height.equalTo(120)
//}
