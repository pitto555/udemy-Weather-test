//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

final class ViewController: UIViewController{
    
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var uiPickerView: UIPickerView!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        uiPickerView.delegate = self
        uiPickerView.dataSource = self
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weatherManager.prefecturesArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weatherManager.prefecturesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectPrefecture = weatherManager.prefecturesArray[row]
        weatherManager.getprefecture(for: selectPrefecture)
    }
}

extension ViewController: Weatherdelegate {
    
    func goto(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.capitalLabel.text = weather.cityName
            self.tempLabel.text = weather.tempString
        }
    }
}




