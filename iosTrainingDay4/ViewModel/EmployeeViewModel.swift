//
//  EmployeeViewModel.swift
//  iosTrainingDay4
//
//  Created by ITBCA on 19/10/23.
//

import Foundation

class EmployeeViewModel:NSObject {
    private var employeeRepository:EmployeeRepository!
    private(set) var employeeData: [EmployeeModel] = [] {
        didSet {
            self.bindDatatToVC()
        }
    }
    
    var bindDatatToVC: () -> () = {}
    var showAlertCreate: () -> () = {}
    
    override init(){
        super.init()
        employeeRepository = EmployeeRepository()
    }
    
    func createData(id:Int, name:String, age:Int, salary:Int){
        let employeeModel = EmployeeModel(id: id, name: name, age: age, salary: salary)
        employeeRepository.create(model: employeeModel)
        self.fetchData()
    }
    
    func updateData(id:Int, name:String, age:Int, salary:Int){
        let employeeModel = EmployeeModel(id: id, name: name, age: age, salary: salary)
        employeeRepository.update(model: employeeModel)
        self.fetchData()
    }
    
    
    func fetchData() {
        let employeesModel = employeeRepository.fetch()
        self.employeeData = employeesModel
    }
    
    func deleteData(id:Int){
        employeeRepository.delete(id: id)
        self.fetchData()
    }
}
