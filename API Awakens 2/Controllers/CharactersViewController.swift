//
//  CharactersViewController.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController, UIPickerViewDelegate {
    
    // Star Wars API Client instance
    let client = StarWarsAPIClient()
    
    // find Big and Small Instance for helper functions
    let findBigAndSmall = FindBigAndSmall()
    
    // Metric/British Units Conversion Tool
    let metricBritishConversion = MetricBritishConversion()
    
    // UIPickerView
    let pickerViewDataSource = CharacterPickerViewDataSource()
    var pickerViewOptionItems = [String]()
    
    var smallestCharacterString = ""
    var largestCharacterString = ""
    
    
    // UI IBOutlets
    
    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var charactersPickerView: UIPickerView!
    @IBOutlet weak var largestCharacter: UILabel!
    @IBOutlet weak var smallestCharacter: UILabel!
    @IBOutlet weak var birth_year: UILabel!
    @IBOutlet weak var home_planet: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var eye_color: UILabel!
    @IBOutlet weak var hair_color: UILabel!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var metricConversionButton: UIButton!
    @IBOutlet weak var englishConversionButton: UIButton!
    
    
    // Units Conversion Button (Metric/English)
    
    @IBAction func convertToMetricUnits(_ sender: Any) {
        let heightText: String? = height.text
        guard let heightValue = heightText, let height_Double = Double(heightValue.doublesOnly) else {
            print("error in yards text")
            return
        }
        height.text = "\(metricBritishConversion.yardsToMeters(height_Double))m"
        englishConversionButton.isEnabled = true
        metricConversionButton.isEnabled = false
    }
    @IBAction func convertToEnglishUnits(_ sender: Any) {
        let heightText: String? = height.text
        guard let heightValue = heightText, let height_Double = Double(heightValue.doublesOnly) else {
            print("error in meters text")
            return
        }
        height.text = "\(metricBritishConversion.metersToYards(height_Double)) yards"
        englishConversionButton.isEnabled = false
        metricConversionButton.isEnabled = true
    }

    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metricConversionButton.setTitleColor(UIColor.darkGray, for: .disabled)
        englishConversionButton.setTitleColor(UIColor.darkGray, for: .disabled)
        metricConversionButton.isEnabled = false
        
        self.charactersPickerView.delegate = self
        self.charactersPickerView.dataSource = pickerViewDataSource
        updatePickerDataSource(forPickerView: charactersPickerView)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UIPickerView
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewDataSource.data[row].name
    }
    
    // Catpure the picker view selection
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for currentCharacter in pickerViewDataSource.data {
            if pickerViewDataSource.data[row].name ==  currentCharacter.name {
                do {
                    let currentCharacterModel = try CharacterViewModel(model: currentCharacter)
                    self.client.getCharacterHomePlanet(with: pickerViewDataSource.data[row].homeworld) { planet, error in
                    self.home_planet.text = self.client.homeplanetString
                    }
                    displayCharacterInformation(using: currentCharacterModel)
                    print("this is the chosen UIPickerView option: \(currentCharacterModel.name)")
                } catch Errors_API_Awakens.stringNotInteger {
                    print("ERROR: Object initialization failed: invalid entry on 'length' or 'costInCredits' property")
                } catch {
                    print("error in API packaged JSON")
                }
            } /*else {
             print(currentVehicle.name)
             }*/
        }
    }
    
    
    // MARK: Helper Functions
    func displayCharacterInformation(using characterViewModel: CharacterViewModel) {
        characterName.text = characterViewModel.name
        birth_year.text = characterViewModel.birth_year
        height.text = characterViewModel.height
        eye_color.text = characterViewModel.eye_color
        hair_color.text = characterViewModel.hair_color
    }
    
 
}

extension CharactersViewController {
    func updatePickerDataSource(forPickerView pickerView: UIPickerView) {
        
        client.getCharacters(with: SWAPI.people(page: nil)) { people, error in
            self.pickerViewDataSource.characterDataUpdate(with: self.client.allDownloadedPeople)
            self.charactersPickerView.reloadAllComponents()
        // to select the first option in the UIPickerView as the "default" info to display in app
            self.pickerView(self.charactersPickerView, didSelectRow: 0, inComponent: 0)
            self.smallestCharacter.text = self.client.findBigAndSmall.smallestOne
            self.largestCharacter.text = self.client.findBigAndSmall.largestOne
        }
    }
}








