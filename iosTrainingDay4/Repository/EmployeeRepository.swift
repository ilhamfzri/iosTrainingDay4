//
//  EmployeeLocalRepository.swift
//  iosTrainingDay4
//
//  Created by ITBCA on 19/10/23.
//

import Foundation
import CoreData
import UIKit

class EmployeeRepository {
    func create(model:EmployeeModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "EmployeeModelData", in: managedContext)
        let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        
        insert.setValue(model.id, forKey: "id")
        insert.setValue(model.name, forKey: "name")
        insert.setValue(model.age, forKey: "age")
        insert.setValue(model.salary, forKey: "salary")
        
        do {
            try managedContext.save()
        } catch let err {
            print("FAILED TO CREATE NEW EMPLOYEE : ", err)
        }
    }
    
    func fetch() -> [EmployeeModel] {
        var employees:[EmployeeModel] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return employees}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeModelData")
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ employee in
            
                employees.append(EmployeeModel(id: employee.value(forKey: "id") as! Int, name: employee.value(forKey: "name") as! String, age: employee.value(forKey: "age") as! Int, salary: employee.value(forKey: "salary") as! Int))
            }
        } catch let err {
            print("FAILED TO FETCH EMPLOYEES : ", err)
        }
        
        return employees
    }
    
    func update(model:EmployeeModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EmployeeModelData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: model.id))
        
        do {
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(model.name, forKey: "name")
            dataToUpdate.setValue(model.salary, forKey: "salary")
            dataToUpdate.setValue(model.age, forKey: "age")
            
        } catch let err {
            print("FAILED TO UPDATE EMPLOYEE : ", err)
        }
    }
    
    func delete(id: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EmployeeModelData")
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        
        do {
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
        }  catch let err {
            print("FAILED TO DELETE EMPLOYEE : ", err)
        }
        
    }
}
