//
//  ActionTableViewCell.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        // titleLabel 설정
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
