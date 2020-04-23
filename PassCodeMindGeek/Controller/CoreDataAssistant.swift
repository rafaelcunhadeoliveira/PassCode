//
//  CoreDataAssistant.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-22.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class CoreDataAssistant {

    func fetchUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserLogged")
        do {
            let response = try managedContext.fetch(fetchRequest)
            if let userInfo = response.first {
                let user = User(code: userInfo.value(forKey: "code") as? String ?? "",
                                isLogged: (userInfo.value(forKey: "isLogged") as? Bool ?? false),
                                blocked: userInfo.value(forKey: "blocked") as? Date)
                User.sharedInstace = user
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func save() {
        deleteRecord()
        saveOnCoreData()
    }

    private func deleteRecord() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserLogged")
        do {
            let users = try managedContext.fetch(fetchRequest)
            for user in users {
                managedContext.delete(user)
            }
        } catch let error as NSError {
          print("Could not delete. \(error), \(error.userInfo)")
        }
    }

    private func saveOnCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserLogged",
                                                in: managedContext)!
        let userLogged = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
        userLogged.setValue(User.sharedInstace.code, forKeyPath: "code")
        userLogged.setValue(User.sharedInstace.blocked, forKeyPath: "blocked")
        userLogged.setValue(User.sharedInstace.isLogged, forKeyPath: "isLogged")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
