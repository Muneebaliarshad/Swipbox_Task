//
//  PersistentStorage.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 21/09/2024.
//

import Foundation
import CoreData


final class PersistentStorage {
    
    //MARK: - Variables
    static let shared = PersistentStorage()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MoviesDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context = persistentContainer.viewContext
    
    
    //MARK: - Init Methods
    private init(){}
    
    
    //MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type, id: Int64 = 0) -> [T]? {
        do {
            let request = managedObject.fetchRequest()
            if id != 0 {
                let predicate = NSPredicate(format: "id == %d", id)
                request.predicate = predicate
            }
            guard let result = try PersistentStorage.shared.context.fetch(request) as? [T] else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
