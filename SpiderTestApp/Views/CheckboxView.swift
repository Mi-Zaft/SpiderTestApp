    //
    //  Checkbox.swift
    //  SpiderTestApp
    //
    //  Created by Максим Евграфов on 21.08.2024.
    //

    import UIKit

    class CheckboxView: UIView {
        private let checkboxView = UIView()
        private let imageView = UIImageView()
        private let label = UILabel()
        private var onViewTap: (() -> Void)?
        
        init() {
            super.init(frame: .zero)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(text: String, state: Bool, onViewTap: @escaping () -> Void) {
            label.text = text
            imageView.image = state ? UIImage(systemName: "checkmark") : nil
            self.onViewTap = onViewTap
        }
    }

    // MARK: - Private Methods
    private extension CheckboxView {
        func commonInit() {
            [
                checkboxView,
                label
            ].forEach {
                addSubview($0)
            }
            checkboxView.addSubview(imageView)
            
            checkboxView.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            checkboxView.layer.borderColor = UIColor(named: ColorConstants.accent.rawValue)?.cgColor
            checkboxView.layer.borderWidth = 2
            checkboxView.layer.cornerRadius = 5
            
            NSLayoutConstraint.activate([
                checkboxView.leadingAnchor.constraint(equalTo: leadingAnchor),
                checkboxView.widthAnchor.constraint(equalToConstant: 30),
                checkboxView.heightAnchor.constraint(equalToConstant: 30),
                checkboxView.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                imageView.centerYAnchor.constraint(equalTo: checkboxView.centerYAnchor),
                imageView.centerXAnchor.constraint(equalTo: checkboxView.centerXAnchor),
                
                label.leadingAnchor.constraint(equalTo: checkboxView.trailingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
            addGestureRecognizer(tap)
        }
        
        @objc private func tapView() {
            onViewTap?()
        }
    }
