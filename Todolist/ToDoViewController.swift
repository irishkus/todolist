//
//  ViewController.swift
//  To do list
//
//  Created by Ирина Соловьева on 30/03/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var importantToDo = ["Сходить к врачу", "Сдать книги в библиотеку", "Сходить на молочную кухню"]
    lazy var commonToDo = ["Соблюдать диету", "Почитать про Core Data", "Закупиться в магазине", "Отвести детей в сад", "Ложиться спать вовремя"]
    lazy var inconsiderableToDo = ["Пить побольше воды", "Есть 5 раз в день"]
    lazy var toDoList = [importantToDo, commonToDo, inconsiderableToDo]
    let cellID = "cellID"
    
    
    var allToDoListTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allToDoListTableView.frame = view.frame
        allToDoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        allToDoListTableView.delegate = self
        allToDoListTableView.dataSource = self
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ToDoViewController.editButtonTapped(button:)))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ToDoViewController.addButtonTapped(button:)))
        addButton.style = .done
        navigationController?.navigationBar.topItem?.title = "Список дел"
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [editButton]
        navigationController?.navigationBar.topItem?.rightBarButtonItems = [addButton]
        view.addSubview(allToDoListTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allToDoListTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = toDoList[indexPath.section][indexPath.row]
        // cell.accessoryType = .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if allToDoListTableView.isEditing == true {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Изменить") { (rowAction, indexPath) in
            let alter = UIAlertController(title: "Изменить дело", message: nil, preferredStyle: .alert)
            alter.addTextField { (configurationHandler) in
                configurationHandler.text = self.toDoList[indexPath.section][indexPath.row]
            }
            let actionOK = UIAlertAction(title: "Сохранить", style: .default, handler: { (alertAction) in
                self.toDoList[indexPath.section][indexPath.row] = alter.textFields?.first?.text ?? self.toDoList[indexPath.section][indexPath.row]
                tableView.reloadData()
            })
            let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alter.addAction(actionOK)
            alter.addAction(actionCancel)
            self.present(alter, animated: true, completion: nil)
        }
        editButton.backgroundColor = UIColor.green
        let deleteButton = UITableViewRowAction(style: .normal, title: "Удалить") { (rowAction, indexPath) in
            self.toDoList[indexPath.section].remove(at: indexPath.row)
            self.allToDoListTableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton, editButton]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        allToDoListTableView.beginUpdates()
        let deleteToDo = toDoList[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        toDoList[destinationIndexPath.section].insert(deleteToDo, at: destinationIndexPath.row)
        allToDoListTableView.endUpdates()
        tableView.reloadData()
    }
    
    @objc func editButtonTapped(button: UIButton) {
        if allToDoListTableView.isEditing == true {
            allToDoListTableView.isEditing = false
        } else {
            allToDoListTableView.isEditing = true
        }
    }
    
    @objc func addButtonTapped(button: UIButton) {
        navigationController?.pushViewController(AddToDoController(), animated: true)    
    }
}

