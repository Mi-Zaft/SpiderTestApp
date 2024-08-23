//
//  ItemViewModel.swift
//  SpiderTestApp
//
//  Created by Максим Евграфов on 20.08.2024.
//

import Foundation

protocol ItemViewModelProtocol {
    var numberOfItems: Int { get }
    var onItemUpdate: (() -> Void)? { get set }
    var onSelectAllButtonStateUpdate: ((Bool) -> Void)? { get set }
    var onSubmitButtonStateUpdate: ((Bool) -> Void)? { get set }
    
    func item(at index: Int) -> Item
    func toggleItemSelection(at index: Int)
    func selectAllTapped(to: Bool)
    func submit()
}

class ItemViewModel: ItemViewModelProtocol {
    var numberOfItems: Int {
        items.count
    }
    
    var onItemUpdate: (() -> Void)?
    
    var onSelectAllButtonStateUpdate: ((Bool) -> Void)?
    
    var onSubmitButtonStateUpdate: ((Bool) -> Void)?
    
    private var items: [Item] = [
        Item(title: "Красный", isRequired: true, isTappedOnSelectAll: true, isSelected: false),
        Item(title: "Зеленый", isRequired: false, isTappedOnSelectAll: false, isSelected: false),
        Item(title: "Синий", isRequired: false, isTappedOnSelectAll: false, isSelected: false),
        Item(title: "Желтый", isRequired: true, isTappedOnSelectAll: true, isSelected: false),
        Item(title: "Фиолетовый", isRequired: true, isTappedOnSelectAll: true, isSelected: false),
        Item(title: "Черный", isRequired: false, isTappedOnSelectAll: false, isSelected: false),
        Item(title: "Белый", isRequired: true, isTappedOnSelectAll: true, isSelected: false)
    ]
    
    func item(at index: Int) -> Item {
        items[index]
    }
    
    func toggleItemSelection(at index: Int) {
        items[index].isSelected.toggle()
        onItemUpdate?()
        updateSelectAllCheckbox()
        updateSubmitButtonState()
    }
    
    func selectAllTapped(to isSelected: Bool) {
        for index in 0..<items.count {
            if items[index].isTappedOnSelectAll {
                items[index].isSelected = isSelected
            }
        }
        onItemUpdate?()
        updateSelectAllCheckbox()
        updateSubmitButtonState()
    }
    
    func submit() {
        print("Отправка формы")
        // Хотел сделать алерт, но решил не отклоняться от ТЗ
    }
    
    private func updateSelectAllCheckbox() {
        let isAllRequiredSelected = items.filter {$0.isRequired}.allSatisfy { $0.isSelected }
        onSelectAllButtonStateUpdate?(isAllRequiredSelected)
    }
    
    private func updateSubmitButtonState() {
        let isAllRequiredSelected = items.filter {$0.isRequired}.allSatisfy { $0.isSelected }
        onSubmitButtonStateUpdate?(isAllRequiredSelected)
    }
    
    
}
