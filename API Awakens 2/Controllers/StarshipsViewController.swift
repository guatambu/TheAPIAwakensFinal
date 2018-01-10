//
//  StarshipsViewController.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import UIKit

class StarshipsViewController: UIViewController, UIPickerViewDelegate {
    
    // Star Wars API Client instance
    let client = StarWarsAPIClient()
    
    // find Big and Small Instance for helper functions
    let findBigAndSmall = FindBigAndSmall()
    
    // Metric/British Units Conversion Tool
    let metricBritishConversion = MetricBritishConversion()
    
    // UIPickerView
    let pickerViewDataSource = StarshipPickerViewDataSource()
    var pickerViewOptionItems = [String]()
    
    // UI IBOutlets
    @IBOutlet weak var starshipsPickerView: UIPickerView!
    @IBOutlet weak var largestStarship: UILabel!
    @IBOutlet weak var smallestStarship: UILabel!
    @IBOutlet weak var starshipMaxCrewNumber: UILabel!
    @IBOutlet weak var starshipClass: UILabel!
    @IBOutlet weak var starshipLength: UILabel!
    @IBOutlet weak var starshipCost: UILabel!
    @IBOutlet weak var starshipMake: UILabel!
    @IBOutlet weak var starshipName: UILabel!
    @IBOutlet weak var metricConversionButton: UIButton!
    @IBOutlet weak var englishConversionButton: UIButton!
    @IBOutlet weak var creditsConversionButton: UIButton!
    @IBOutlet weak var USDollarConversionButton: UIButton!
    
    
    // Units Conversion Button (Metric/English)
    
    @IBAction func convertToMetricUnits(_ sender: Any) {
        let starshipLengthText: String? = starshipLength.text
        guard let starshipLengthValue = starshipLengthText, let starshipLength_Double = Double(starshipLengthValue.doublesOnly) else {
            print("error in yards text")
            return
        }
        starshipLength.text = "\(metricBritishConversion.yardsToMeters(starshipLength_Double))m"
        englishConversionButton.isEnabled = true
        metricConversionButton.isEnabled = false
    }
    @IBAction func convertToEnglishUnits(_ sender: Any) {
        let starshipLengthText: String? = starshipLength.text
        guard let starshipLengthValue = starshipLengthText, let starshipLength_Double = Double(starshipLengthValue.doublesOnly) else {
            print("error in meters text")
            return
        }
        starshipLength.text = "\(metricBritishConversion.metersToYards(starshipLength_Double)) yards"
        englishConversionButton.isEnabled = false
        metricConversionButton.isEnabled = true
    }
    
    
    // Currency Conversion Credits US Dollars
    var userInputCurrencyExchangeRate: String? = ""
    let creditsUSDollarsConversion = CreditsUSDollarsConversion()
    
    @IBAction func convertToCredits(_ sender: Any) {
        if USDollarConversionButton.isEnabled == false {
            let starshipCostText: String? = starshipCost.text
            guard let starshipCostValue = starshipCostText, let starshipCost_Double = Double(starshipCostValue.doublesOnly) else {
                print("error in user cost text")
                return
            }
            guard let userRateValue = userInputCurrencyExchangeRate, let userRate_Double = Double(userRateValue.doublesOnly) else {
                print("error in user input text")
                return
            }
            starshipCost.text = "\(creditsUSDollarsConversion.convertUSDollarsToCredits(starshipCost_Double, userRate_Double))"
            USDollarConversionButton.isEnabled = true
            creditsConversionButton.isEnabled = false
        }
    }
    @IBAction func convertToUSDollar(_ sender: Any) {
        // See Internal Function at bottom
        presentUserInputCurrencyExchangeRateAlert()
    }
    
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditsConversionButton.setTitleColor(UIColor.darkGray, for: .disabled)
        USDollarConversionButton.setTitleColor(UIColor.darkGray, for: .disabled)
        metricConversionButton.setTitleColor(UIColor.darkGray, for: .disabled)
        englishConversionButton.setTitleColor(UIColor.darkGray, for: .disabled)
        metricConversionButton.isEnabled = false
        
        self.starshipsPickerView.delegate = self
        self.starshipsPickerView.dataSource = pickerViewDataSource
        updatePickerDataSource(forPickerView: starshipsPickerView)
        
        currencyButtonsActive()
        print(pickerViewDataSource)
        
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
        for currentStarship in pickerViewDataSource.data {
            if pickerViewDataSource.data[row].name ==  currentStarship.name {
                do {
                    let currentStarshipModel = try StarshipViewModel(model: currentStarship)
                    displayStarshipInformation(using: currentStarshipModel)
                    currencyButtonsActive()
                    print("this is the chosen UIPickerView option: \(currentStarshipModel.name)")
                } catch Errors_API_Awakens.stringNotInteger {
                    print("ERROR: Object initialization failed: invalid entry on 'length' or 'costInCredits' property")
                } catch {
                    print("error in API packaged JSON")
                }
            } /*else {
             print(currentStarship.name)
             }*/
        }
    }
    
    
    // MARK: Helper Functions
    func displayStarshipInformation(using starshipViewModel: StarshipViewModel) {
        starshipName.text = starshipViewModel.name
        starshipMake.text = starshipViewModel.make
        starshipCost.text = starshipViewModel.cost_in_credits
        starshipLength.text = starshipViewModel.length
        starshipClass.text = starshipViewModel.starship_class
        starshipMaxCrewNumber.text = starshipViewModel.crew
    }
    
    func currencyButtonsActive() {
        if starshipCost.text == "unknown" {
            creditsConversionButton.isEnabled = false
            USDollarConversionButton.isEnabled = false
        } else if starshipCost.text != "unknown" {
            creditsConversionButton.isEnabled = false
            USDollarConversionButton.isEnabled = true
        }
    }
    
    func presentUserInputCurrencyExchangeRateAlert() {
        let alertController = UIAlertController(title: "Exchange Rate", message: "Please enter the value of 1 Galactic Credit in U.S. Dollars($) :", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                // store user input
                if field.text != "" {
                    self.userInputCurrencyExchangeRate = field.text
                    guard let userRateValue = self.userInputCurrencyExchangeRate, let userRate_Double = Double(userRateValue.doublesOnly) else {
                        print("error in user input text")
                        return
                    }
                    let starshipCostText: String? = self.starshipCost.text
                    guard let starshipCostValue = starshipCostText, let starshipCost_Double = Double(starshipCostValue.doublesOnly) else {
                        print("error in user cost text")
                        return
                    }
                    self.starshipCost.text = "$\(self.creditsUSDollarsConversion.convertCreditsToUSDollars(starshipCost_Double, userRate_Double))0"
                    self.USDollarConversionButton.isEnabled = false
                    self.creditsConversionButton.isEnabled = true
                    
                } else {
                    print("no user input")
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // finding smallest and largest vehicles 1/2
    
    func currentStarshipLengthDictionaryMaker() -> [String: Double] {
        var currentStarshipLengths = [String: Double]()
        let starships = pickerViewDataSource.data
        for starship in starships {
            guard let starshipLengthDouble = Double(starship.length) else {
                print("found nil value while trying to make the currentVehicleLengths in the Dictionary maker function")
                return currentStarshipLengths
            }
            currentStarshipLengths.updateValue(starshipLengthDouble, forKey: starship.name)
        }
        return currentStarshipLengths
    }
    
    // finding smallest and largest vehicles 2/2
    func findSmallestAndLargest() {
        let currentStarshipLengths = currentStarshipLengthDictionaryMaker()
        
        let minimum = currentStarshipLengths.min { a, b in a.value < b.value }
        let maximum = currentStarshipLengths.max { a, b in a.value < b.value }
        guard let smallest = minimum else {
            print("couldn't find smallest vehicle")
            return
        }
        guard let largest = maximum else {
            print("couldn't find largest vehicle")
            return
        }
        
        smallestStarship.text = String(smallest.key)
        largestStarship.text = String(largest.key)
    }
    
}


extension StarshipsViewController {
    func updatePickerDataSource(forPickerView pickerView: UIPickerView) {
        client.getStarships(with: SWAPI.spaceships(page: nil)) { starships, error in
            self.pickerViewDataSource.starshipDataUpdate(with: self.client.allDownloadedStarships)
            self.starshipsPickerView.reloadAllComponents()
            // to select the first option in the UIPickerView as the "default" info to display in app
            self.pickerView(self.starshipsPickerView, didSelectRow: 0, inComponent: 0)
            self.smallestStarship.text = self.client.findBigAndSmall.smallestOne
            self.largestStarship.text = self.client.findBigAndSmall.largestOne
        }
    }
}

















