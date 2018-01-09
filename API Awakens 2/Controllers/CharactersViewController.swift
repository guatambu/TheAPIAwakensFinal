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
    
    // Metric/British Units Conversion Tool
    let metricBritishConversion = MetricBritishConversion()
    
    // UIPickerView
    let pickerViewDataSource = CharacterPickerViewDataSource()
    var pickerViewOptionItems = [String]()
    
    
    
    // UI IBOutlets
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
        home_planet.text = characterViewModel.homeworld
        height.text = characterViewModel.height
        eye_color.text = characterViewModel.eye_color
        hair_color.text = characterViewModel.hair_color
    }
    
    // finding smallest and largest vehicles 1/2
    
    func currentCharacterHeightDictionaryMaker() -> [String: Double] {
        var currentCharacterHeights = [String: Double]()
        let characters = pickerViewDataSource.data
        for character in characters {
            guard let characterHeightDouble = Double(character.height) else {
                print("found nil value while trying to make the currentCharacterHeights in the Dictionary maker function")
                return currentCharacterHeights
            }
            currentCharacterHeights.updateValue(characterHeightDouble, forKey: character.name)
        }
        return currentCharacterHeights
    }
    
    // finding smallest and largest vehicles 2/2
    func findSmallestAndLargest() {
        let currentCharacterHeights = currentCharacterHeightDictionaryMaker()
        let minimum = currentCharacterHeights.min { a, b in a.value < b.value }
        let maximum = currentCharacterHeights.max { a, b in a.value < b.value }
        guard let smallest = minimum else {
            print("couldn't find shortest character")
            return
        }
        guard let largest = maximum else {
            print("couldn't find tallest character")
            return
        }
        
        smallestCharacter.text = String(smallest.key)
        largestCharacter.text = String(largest.key)
    }
}

extension CharactersViewController {
        func updatePickerDataSource(forPickerView pickerView: UIPickerView) {
            client.getCharacters(with: SWAPI.people(page: nil)) { people, error in
                self.pickerViewDataSource.characterDataUpdate(with: self.client.allDownloadedPeople)
                self.charactersPickerView.reloadAllComponents()
            // to select the first option in the UIPickerView as the "default" info to display in app
                self.pickerView(self.charactersPickerView, didSelectRow: 0, inComponent: 0)
                let miDict = self.currentCharacterHeightDictionaryMaker()
                self.findSmallestAndLargest()
        }
    }
 }









