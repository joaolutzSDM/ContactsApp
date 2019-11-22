//
//  ViewController.swift
//  AgendaContatos
//
//  Created by JohnnyLutz on 20/11/19.
//  Copyright © 2019 JohnnyLutz. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    
    var contatos: [NSManagedObject] = []
    
    @IBOutlet weak var tbvContatos: UITableView!
    
    @IBAction func btnCadastrar(_ sender: Any) {
        //abre a tela de cadastro com os campos em branco para cadastro de um novo contato
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Contato")
        
        //3
        do {
            contatos = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return contatos.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let person = contatos[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
                                              for: indexPath)
            cell.textLabel?.text =
                person.value(forKeyPath: "nome") as? String
            cell.detailTextLabel?.text = person.value(forKeyPath: "telefone") as? String
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contato = contatos[indexPath.row]
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        myVC.contato = contato
        navigationController?.pushViewController(myVC, animated: true)
    }

}
