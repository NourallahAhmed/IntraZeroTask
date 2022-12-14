//
//  PersistenceController.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container : NSPersistentContainer
    
    init(){
        
        self.container = NSPersistentContainer(name: "Stash")
        container.loadPersistentStores { (description , error)in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: Save
    func save(completion: @escaping (Error?) -> () = {_ in } ){
        let context = container.viewContext
        
        if context.hasChanges{
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
        
    }
    
    
    func delete(_ object: NSManagedObject ,completion: @escaping (Error?) -> () = {_ in }){
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
}
