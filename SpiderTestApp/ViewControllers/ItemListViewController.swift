//
//  ViewController.swift
//  SpiderTestApp
//
//  Created by Максим Евграфов on 20.08.2024.
//

import UIKit

class ItemListViewController: UIViewController {
    
    private var viewModel: ItemViewModelProtocol
    
    private let tableView = UITableView()
    private let selectAllCheckboxButton = CheckboxView()
    private let submitButton = UIButton(type: .system)
    
    init(viewModel: ItemViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "itemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        selectAllCheckboxButton.configure(text: "Выбрать всё", state: false) { [weak self] in
            self?.viewModel.selectAllTapped()
        }
        
        selectAllCheckboxButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectAllCheckboxButton)
        
        submitButton.setTitle("Отправить", for: .normal)
        submitButton.backgroundColor = UIColor(named: ColorConstants.accent.rawValue)
        submitButton.tintColor = .white
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.isEnabled = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            selectAllCheckboxButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            selectAllCheckboxButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            selectAllCheckboxButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            selectAllCheckboxButton.heightAnchor.constraint(equalToConstant: 60),
            
            submitButton.topAnchor.constraint(equalTo: selectAllCheckboxButton.bottomAnchor, constant: 10),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Private Methods
private extension ItemListViewController {
    func setupBindings() {
        viewModel.onItemUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onSelectAllButtonStateUpdate = { [weak self] isSelected in
            self?.selectAllCheckboxButton.configure(text: "Выбрать всё", state: isSelected) { [weak self] in
                self?.viewModel.selectAllTapped()
            }
        }
        
        viewModel.onSubmitButtonStateUpdate = { [weak self] isEnabled in
            self?.submitButton.isEnabled = isEnabled
        }
    }
    
    @objc func selectAllTapped() {
        
    }
    
    @objc func submitTapped() {
        viewModel.submit()
    }
}

// MARK: - UI TableView Data Source
extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.item(at: indexPath.row)
        cell.configure(text: item.title, state: item.isSelected)
        cell.checkboxTappedHandler = { [weak self] in
            self?.viewModel.toggleItemSelection(at: indexPath.row)
        }
        
        return cell
    }
    
    
}

// MARK: - UI TableView Delegate
extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = UITableView.automaticDimension
        return 44
    }
}

