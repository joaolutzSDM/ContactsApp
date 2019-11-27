//
//  SecondVC.swift
//  AgendaContatos
//
//  Created by JohnnyLutz on 22/11/19.
//  Copyright © 2019 JohnnyLutz. All rights reserved.
//

import UIKit
import CoreData

class SecondVC: UIViewController {

    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCategoria: UITextField!
    
    public var contato: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //carrega os dados do contato selecionado na tela para edição
        if(contato != nil) {
            txtNome.text = contato.value(forKey: "nome") as? String
            txtTelefone.text = contato.value(forKey: "telefone") as? String
            txtCategoria.text = contato.value(forKey: "categoria") as? String
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        if(contato == nil) {
            save()
        } else {
            update()
        }
        navigationController?.popViewController(animated: true)
    }
    
    func save() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Contato",
                                       in: managedContext)!
        contato = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        // 3
        contato.setValue(txtNome.text, forKeyPath: "nome")
        contato.setValue(txtTelefone.text, forKeyPath: "telefone")
        contato.setValue(txtCategoria.text, forKeyPath: "categoria")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func update() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 3
        contato.setValue(txtNome.text, forKeyPath: "nome")
        contato.setValue(txtTelefone.text, forKeyPath: "telefone")
        contato.setValue(txtCategoria.text, forKeyPath: "categoria")
        
        // 4
        do {
            try contato.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func btnExcluir(_ sender: Any) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        managedContext.delete(contato)
        
        // 4
        do {
            try contato.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
