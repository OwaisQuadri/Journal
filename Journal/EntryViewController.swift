//
//  EntryViewController.swift
//  Journal
//
//  Created by Owais Quadri on 2023-07-03.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var entryBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var entryTextInput: UITextView!
    @IBOutlet weak var entryDate: UIDatePicker!
    //access to appdelegate
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification observer (move constraints based on if keyboard shows up)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if entry == nil {
            // create new entry
            if let context = delegate?.persistentContainer.viewContext {
                // access to coredata in here
                // add entry
                let entry = Entry(context: context)
                entry.date = entryDate.date
                entry.text = entryTextInput.text
                self.entry = entry
            }
        }
        // fill in old entry
        entryTextInput.text = entry!.text
        if let dateToBeShown = entry!.date {
            entryDate.date = dateToBeShown
        }
        entryTextInput.delegate = self
        entryTextInput.becomeFirstResponder()
    }

    @IBAction func deleteEntry(_ sender: Any) {
        if entry != nil {
            if let context = delegate?.persistentContainer.viewContext {
                context.delete(entry!)
                try? context.save()
            }
                
        }
        // go back
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Respond to Keyboard
    @objc func keyboardWillShow (notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRect.height
            
            entryBottomConstraint.constant = keyboardHeight
        }
    }
    
    @objc func keyboardWillHide (notification: NSNotification) {
        entryBottomConstraint.constant = 0
    }
    
    // MARK: - Autosave
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryTextInput.text
        delegate?.saveContext()
    }
    @IBAction func dateDidChange(_ sender: Any) {
        entry?.date = entryDate.date
        delegate?.saveContext()
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
