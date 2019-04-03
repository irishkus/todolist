//
//  AddToDoController.swift
//  To do list
//
//  Created by Ирина Соловьева on 01/04/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import UIKit

class AddToDoController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        view.backgroundColor = UIColor.white
        addElements()
    }
    
    func addElements() {
        let labelHeadline = UILabel()
        let labelName = UILabel()
        let textFieldName = UITextField()//frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let labelImportance = UILabel()
        let pickerViewImportance = UIPickerView()
        let buttonSave = UIButton()
        let buttonCancel = UIButton()
        pickerViewImportance.delegate = self
        pickerViewImportance.dataSource = self
        view.addSubview(labelHeadline)
        view.addSubview(labelName)
        view.addSubview(textFieldName)
        view.addSubview(labelImportance)
        view.addSubview(pickerViewImportance)
        view.addSubview(buttonSave)
        view.addSubview(buttonCancel)
        labelHeadline.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelImportance.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        pickerViewImportance.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        labelHeadline.text = "Для добавления нового дела введите его название и выберете важность"
        labelHeadline.numberOfLines = 0
        labelHeadline.textAlignment = .center
        labelHeadline.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        labelHeadline.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0).isActive = true
        labelHeadline.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelName.text = "Название"
        labelName.topAnchor.constraint(equalTo: labelHeadline.bottomAnchor, constant: 40.0).isActive = true
        labelName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        labelImportance.text = "Важность"
        textFieldName.topAnchor.constraint(equalTo: labelHeadline.bottomAnchor, constant: 35.0).isActive = true
        textFieldName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130.0).isActive = true
        textFieldName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        textFieldName.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        textFieldName.borderStyle = UITextField.BorderStyle.line
        textFieldName.placeholder = "Введите название"
        textFieldName.clearButtonMode = UITextField.ViewMode.whileEditing
        textFieldName.allowsEditingTextAttributes = true
        textFieldName.keyboardType = UIKeyboardType.default
        textFieldName.returnKeyType = UIReturnKeyType.default
        labelImportance.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 52.0).isActive = true
        labelImportance.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        pickerViewImportance.topAnchor.constraint(equalTo: labelHeadline.bottomAnchor, constant: 50.0).isActive = true
        pickerViewImportance.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130.0).isActive = true
        pickerViewImportance.widthAnchor.constraint(equalToConstant: 220.0).isActive = true
        pickerViewImportance.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        buttonCancel.setTitle("Отмена", for: .normal)
        buttonCancel.addTarget(self, action: #selector(buttonTappedCancel(button:)), for: .touchUpInside)
        buttonCancel.backgroundColor = UIColor.gray
        buttonCancel.topAnchor.constraint(equalTo: labelImportance.bottomAnchor, constant: 100.0).isActive = true
        buttonCancel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80.0).isActive = true
        buttonCancel.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        buttonSave.setTitle("Сохранить", for: .normal)
        buttonCancel.addTarget(self, action: #selector(buttonTappedSave(button:)), for: .touchUpInside)  //(button:, newToDo))
        buttonSave.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        buttonSave.topAnchor.constraint(equalTo: labelImportance.bottomAnchor, constant: 100.0).isActive = true
        buttonSave.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 220.0).isActive = true
        buttonSave.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        buttonSave.heightAnchor.constraint(equalToConstant: 30.0).isActive = true

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Важные"
        case 1:
            return "Обычные"
        case 2:
            return "Не значительные"
        default:
            return "Другое"
        }
    }
    
    @objc func buttonTappedCancel(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonTappedSave(button: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //          let addToDoController : AddToDoController = segue.destination as! AddToDoController
  //          let toDoController = segue.source as! ToDoViewController
          //  addToDoController.button
//        if let indexPath = myFriendsController.tableView.indexPathForSelectedRow {
//            if searchActive {
//                arrayMyFriendsCharacter = []
//                for user in arrayFilteredFriends! {
//                    arrayMyFriendsCharacter.append(user.name)
//                }
//            }
   // }
}
