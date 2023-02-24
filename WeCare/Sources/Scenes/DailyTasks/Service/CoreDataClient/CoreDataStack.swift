//
//  CoreDataStack.swift
//  WeCare
//
//  Created by Yago Marques on 16/02/23.
//

import Foundation
import CoreData

struct CoreDataStack {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeCare")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
}
