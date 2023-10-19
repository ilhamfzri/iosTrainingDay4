//
//  EmployeeListViewController.swift
//  iosTrainingDay4
//
//  Created by ITBCA on 19/10/23.
//

import UIKit
import CoreData

private let tableViewCell = "EmployeeDataViewCell"

class EmployeeListViewController: UIViewController {
    @IBOutlet weak var employeeTableView: UITableView!
    
    private var employeeViewModel:EmployeeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // # Initialize Table
        employeeTableView.delegate = self
        employeeTableView.delegate = self
        employeeTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: tableViewCell)
        
        employeeTableView.rowHeight = 80
        employeeTableView.allowsFocus = false
        employeeTableView.estimatedRowHeight = 500
        
        // # Initialize ViewModel
        employeeViewModel = EmployeeViewModel()
        employeeViewModel.bindDatatToVC = employeeTableView.reloadData
        
        employeeViewModel.fetchData()
    }
    
    
    
    // # Handling Create New Employee Data
    @IBAction func clickedAddButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New Employee", message: "Fill the form below to add new employee",  preferredStyle: .alert)
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Id"
            tf.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Name"})
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Age"
            tf.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Salary"
            tf.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {action in
            if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty || alert.textFields![3].text!.isEmpty {
                let warning = UIAlertController(title: "Warning", message: "Fill all the textfields", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(warning, animated: true)
            } else {
                
                self.employeeViewModel.createData(id: Int(alert.textFields![0].text!) ?? 0, name: alert.textFields![1].text!, age: Int(alert.textFields![2].text!) ?? 0, salary: Int(alert.textFields![3].text!) ?? 0)
                
                let success = UIAlertController(title: "Success", message: "Data employee added", preferredStyle: .alert)
                success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                
                self.present(success, animated: true)
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handlingUpdateData(index:Int){
        print("On Clicked Edit Employee")
        
        let alert = UIAlertController(title: "Edit Employee", message: "",  preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Name"})
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Age"})
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "Salary"})
        
        
        
        alert.textFields![0].text = employeeViewModel.employeeData[index].name
        alert.textFields![1].text = String(employeeViewModel.employeeData[index].age)
        alert.textFields![2].text = String(employeeViewModel.employeeData[index].salary)
        
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {action in
            if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty{
                let warning = UIAlertController(title: "Warning", message: "Fill all the textfields", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(warning, animated: true)
            } else {
                
                let newId:Int = self.employeeViewModel.employeeData[index].id
                let newName:String = alert.textFields![0].text!
                let newAge:Int = Int(alert.textFields![1].text!)!
                let newSalary:Int = Int(alert.textFields![2].text!)!
                
                self.employeeViewModel.updateData(id: newId, name: newName, age: newAge, salary: newSalary)
                
                let success = UIAlertController(title: "Success", message: "Data employee updated", preferredStyle: .alert)
                success.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                
                self.present(success, animated: true)
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension EmployeeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeViewModel.employeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: tableViewCell, for: indexPath) as! EmployeeTableViewCell
        employeeTableViewCell.setValue(data: employeeViewModel.employeeData[indexPath.row])
        return employeeTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handlingUpdateData(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let id:Int = self.employeeViewModel.employeeData[indexPath.row].id
            self.employeeViewModel.deleteData(id:id)
        }
    }
}
