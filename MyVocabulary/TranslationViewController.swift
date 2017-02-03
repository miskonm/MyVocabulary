//
//  FirstViewController.swift
//  MyVocabulary
//
//  Created by Nikita Misko on 03.02.17.
//  Copyright © 2017 Nikita Misko. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var firstLanguageLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet weak var secondLanguageLabel: UILabel!
    @IBOutlet weak var secondLanguageTranslatedLabel: UILabel!
    @IBOutlet weak var secondLanguageButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var translationOptionsLabel: UILabel!
    
    // MARK: - Variables
    var application: UIApplication!
    var translation: Translation?
    
    
    // MARK: - @IBActions
    
    @IBAction func clearButtonPressed() {
        textField.text! = ""
        clearButton.isHidden = true
        textField.becomeFirstResponder()
        updateLabels()
    }
    
    @IBAction func secondLanguageButtonPressed() {
        
    }
    
    @IBAction func translate() {
        application.isNetworkActivityIndicatorVisible = true
        Translation.getTranslation(with: textField.text!) { (translation) in
            self.translation = translation
            self.updateLabels()
            self.application.isNetworkActivityIndicatorVisible = false
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Metods

    func updateLabels() {
        if translation == nil {
            secondLanguageTranslatedLabel.text = ""
            translationOptionsLabel.text = ""
        } else if textField.text! == "" {
            translation = nil
            updateLabels()
        } else {
            secondLanguageTranslatedLabel.text = translation!.translatedWord.lowercased()
            translationOptionsLabel.text = "Варианты перевода"
        }
    }
}

extension TranslationViewController: UITableViewDelegate {
    
}

extension TranslationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension TranslationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length == textField.text?.characters.count && string == "" {
            clearButton.isHidden = true
        } else {
            clearButton.isHidden = false
        }
        
        return true
    }
    
    
    
}


























