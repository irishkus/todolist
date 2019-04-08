//
//  CoreDataProvider.swift
//  Todolist
//
//  Created by Ирина Соловьева on 05/04/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataProvider {
    
    static func coreDataSave(important: Int16, toDo: String){
        if let application =  UIApplication.shared.delegate as? AppDelegate {
            let context = application.persistentContainer.viewContext
            
            let commonToDo = CommonToDo(context: context)
            commonToDo.toDo = toDo
            commonToDo.important = important
            application.saveContext()
            print(toDo)
            let urls = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
            print(urls[urls.count-1] as URL)
        }
    }
    
    static func coreDataLoad(important: Int16) -> [String] {
        var arrayToDo: [String] = []
        if let application = UIApplication.shared.delegate as? AppDelegate {
            let context = application.persistentContainer.viewContext
            guard let resultsOpt = try? context.fetch(CommonToDo.fetchRequest()), let results = resultsOpt as? [CommonToDo] else {preconditionFailure("Bad fetch results")}
            for result in results {
                guard let commonNewToDo = result.toDo else {return []}
                if important == result.important {
                    arrayToDo.append(commonNewToDo)
                }
            }
        }
        return arrayToDo
    }
    
    static func coreDataDelete(important: Int16, toDo: String) {
        if let application = UIApplication.shared.delegate as? AppDelegate {
            let context = application.persistentContainer.viewContext
            guard let resultsOpt = try? context.fetch(CommonToDo.fetchRequest()), let results = resultsOpt as? [CommonToDo] else {preconditionFailure("Bad fetch results")}
            for result in results {
                if result.toDo == toDo {
                    context.delete(result)
                }
            }
            application.saveContext()
        }
    }
    
    static func coreDataUpdate(important: Int16, changeToDo: String, newToDo: String) {
        if let application = UIApplication.shared.delegate as? AppDelegate {//else {preconditionFailure("Bad arrayFilteredFriends")}
            let context = application.persistentContainer.viewContext
            guard let resultsOpt = try? context.fetch(CommonToDo.fetchRequest()), let results = resultsOpt as? [CommonToDo] else {preconditionFailure("Bad fetch results")}
            for result in results {
                if result.toDo == changeToDo {
                    result.toDo = newToDo
                }
            }
            application.saveContext()
        }
    }
    
}

