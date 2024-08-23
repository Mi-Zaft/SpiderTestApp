//
//  ItemTableViewCell.swift
//  SpiderTestApp
//
//  Created by Максим Евграфов on 20.08.2024.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    let checkboxView = CheckboxView()
    var checkboxTappedHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, state: Bool) {
        checkboxView.configure(text: text, state: state) { [weak self] in
            self?.checkboxTappedHandler?()
        }
    }
}

// MARK: - Private Methods
private extension ItemTableViewCell {
    func setupUI() {
        contentView.addSubview(checkboxView)
    
        checkboxView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkboxView.topAnchor.constraint(equalTo: contentView.topAnchor),
            checkboxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
