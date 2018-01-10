//
//  VehiclesViewController.swift
//  API Awakens 2
//
//  Created by Michael Guatambu Davis on 1/2/18.
//  Copyright © 2018 leme group. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController, UIPickerViewDelegate {
    
    // Star Wars API Client instance
    let client = StarWarsAPIClient()
    
    // find Big and Small Instance for helper functions
    let findBigAndSmall = FindBigAndSmall()
    
    // Metric/British Units Conversion Tool
    let metricBritishConversion = MetricBritishConversion()
    
    // UIPickerView
    let pickerViewDataSource = VehiclePickerViewDataSource()
    var pickerViewOptionItems = [String]()
    
    var smallestVehicleString = ""
    var largestVehicleString = ""
    
    // UI IBOutlets
    @IBOutlet weak var vehiclesPickerView: UIPickerView!
    @IBOutlet weak var largestVehicle: UILabel!
    @IBOutlet weak var smallestVehicle: UILabel!
    @IBOutlet weak var vehicleMaxCrewNumber: UILabel!
    @IBOutlet weak var vehicleClass: UILabel!
    @IBOutlet weak var vehicleLength: UILabel!
    @IBOutlet weak var vehicleCost: UILabel!
    @IBOutlet weak var vehicleMake: UILabel!
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var metricConversionButton: UIButton!
    @IBOutlet weak var englishConversionButton: UIButton!
    @IBOutlet weak var creditsConversionButton: UIButton!
    @IBOutlet weak var USDollarConversionButton: UIButton!
    
    
    // Units Conversion Button (Metric/English)
    
    @IBAction func convertToMetricUnits(_ sender: Any) {
        let vehicleLengthText: String? = vehicleLength.text
        guard let vehicleLengthValue = vehicleLengthText, let vehicleLength_Double = Double(vehicleLengthValue.doublesOnly) else {
            print("error in yards text")
            return
        }
        vehicleLength.text = "\(metricBritishConversion.yardsToMeters(vehicleLength_Double))m"
        englishConversionButton.isEnabled = true
        metricConversionButton.isEnabled = false
    }
    @IBAction func convertToEnglishUnits(_ sender: Any) {
        let vehicleLengthText: String? = vehicleLength.text
        guard let vehicleLengthValue = vehicleLengthText, let vehicleLength_Double = Double(vehicleLengthValue.doublesOnly) else {
            print("error in meters text")
            return
        }
        vehicleLength.text = "\(metricBritishConversion.metersToYards(vehicleLength_Double)) yards"
        englishConversionButton.isEnabled = false
        metricConversionButton.isEnabled = true
    }
    
    
    // Currency Conversion Credits US Dollars
    var userInputCurrencyExchangeRate: String? = ""
    let creditsUSDollarsConversion = CreditsUSDollarsConversion()
    
    @IBAction func convertToCredits(_ sender: Any) {
        if USDollarConversionButton.isEnabled == false {
            let vehicleCostText: String? = vehicleCost.text
            guard let vehicleCostValue = vehicleCostText, let vehicleCost_Double = Double(vehicleCostValue.doublesOnly) else {
                print("error in user cost text")
                return
            }
            guard let userRateValue = userInputCurrencyExchangeRate, let userRate_Double = Double(userRateValue.doublesOnly) else {
                print("error in user input text")
                return
            }
            vehicleCost.text = "\(creditsUSDollarsConversion.convertUSDollarsToCredits(vehicleCost_Double, userRate_Double))"
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
        
        self.vehiclesPickerView.delegate = self
        self.vehiclesPickerView.dataSource = pickerViewDataSource
        updatePickerDataSource(forPickerView: vehiclesPickerView)
        
        currencyButtonsActive()
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
        for currentVehicle in pickerViewDataSource.data {
            if pickerViewDataSource.data[row].name ==  currentVehicle.name {
                do {
                    let currentVehicleModel = try VehicleViewModel(model: currentVehicle)
                    displayVehicleInformation(using: currentVehicleModel)
                    currencyButtonsActive()
                    print("this is the chosen UIPickerView option: \(currentVehicleModel.name)")
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
    func displayVehicleInformation(using vehicleViewModel: VehicleViewModel) {
        vehicleName.text = vehicleViewModel.name
        vehicleMake.text = vehicleViewModel.make
        vehicleCost.text = vehicleViewModel.cost_in_credits
        vehicleLength.text = vehicleViewModel.length
        vehicleClass.text = vehicleViewModel.vehicle_class
        vehicleMaxCrewNumber.text = vehicleViewModel.crew
    }
    
    func currencyButtonsActive() {
        if vehicleCost.text == "unknown" {
            creditsConversionButton.isEnabled = false
            USDollarConversionButton.isEnabled = false
        } else if vehicleCost.text != "unknown" {
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
                    let vehicleCostText: String? = self.vehicleCost.text
                    guard let vehicleCostValue = vehicleCostText, let vehicleCost_Double = Double(vehicleCostValue.doublesOnly) else {
                        print("error in user cost text")
                        return
                    }
                    self.vehicleCost.text = "$\(self.creditsUSDollarsConversion.convertCreditsToUSDollars(vehicleCost_Double, userRate_Double))0"
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
    
    func currentVehicleLengthDictionaryMaker() -> [String: Double] {
        var currentVehicleLengths = [String: Double]()
        let vehicles = pickerViewDataSource.data
        for vehicle in vehicles {
            guard let vehicleLengthDouble = Double(vehicle.length) else {
                print("found nil value while trying to make the currentVehicleLengths in the Dictionary maker function")
                return currentVehicleLengths
            }
            currentVehicleLengths.updateValue(vehicleLengthDouble, forKey: vehicle.name)
        }
        return currentVehicleLengths
    }
    
    // finding smallest and largest vehicles 2/2
    func findSmallestAndLargest() -> (min: String, max: String){
        let currentVehicleLengths = currentVehicleLengthDictionaryMaker()
        
        let minimum = currentVehicleLengths.min { a, b in a.value < b.value }
        let maximum = currentVehicleLengths.max { a, b in a.value < b.value }
        guard let smallest = minimum else {
            print("couldn't find smallest vehicle")
            return (minimum!.key, maximum!.key)
        }
        guard let largest = maximum else {
            print("couldn't find largest vehicle")
            return (minimum!.key, maximum!.key)
        }
        smallestVehicleString = smallest.key
        largestVehicleString = largest.key
        /*
        var maxAndMin = client.findLargestAndSmallest(current: pickerViewDataSource.data as! [StarWarsEntity])
        
        
        smallestVehicle.text = maxAndMin.min //smallest.key
        largestVehicle.text = maxAndMin.max //largest.key
        */
        return (smallestVehicleString, largestVehicleString)
    }
}

extension VehiclesViewController {
    func updatePickerDataSource(forPickerView pickerView: UIPickerView) {
        client.getVehicles(with: SWAPI.vehicles(page: nil)) { vehicles, error in
            self.pickerViewDataSource.vehicleDataUpdate(with: self.client.allDownloadedVehicles)
            self.vehiclesPickerView.reloadAllComponents()
            // to select the first option in the UIPickerView as the "default" info to display in app
            self.pickerView(self.vehiclesPickerView, didSelectRow: 0, inComponent: 0)
            self.smallestVehicle.text = self.client.findBigAndSmall.smallestOne
            self.largestVehicle.text = self.client.findBigAndSmall.largestOne
        }
    }
}




















