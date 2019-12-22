//
//  NotesListViewController.swift
//  NotePad
//
//  Created by sourav sachdeva on 21/12/19.
//  Copyright © 2019 sourav sachdeva. All rights reserved.
//

import UIKit

class NotesListViewController: UITableViewController {

    let cellIdentifier = "NotesListCell"
    var notes = [Note](){
        didSet{
            tableView.reloadData()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
              let noteToDelete = notes[indexPath.row]
              CoreDataHelper.delete(note: noteToDelete)
              notes = CoreDataHelper.retrieveNotes()
          }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NotesListTableViewCell
        let note = notes[indexPath.row]
        cell.noteTitle.text = note.title
        cell.lastModified.text = convertDateToString(date: note.modificationTime ?? Date()) 
    //    cell.lastModified.text = note.convertToString(modificationTime: note.modificationTime)
          return cell
    }
    func convertDateToString(date: Date)->String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

       return formatter.string(from: date)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let identifier = segue.identifier else { return }

           switch identifier {
           case "displayNote":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
               let note = notes[indexPath.row]
               let destination = segue.destination as! DisplayNoteViewController
               destination.note = note
           case "addNote":
               print("create note bar button item tapped")

           default:
               print("unexpected segue identifier")
           }
    }
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
         notes = CoreDataHelper.retrieveNotes()
    }

}
