//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    // MARK: - Properties
    
    var alarm: Alarm?
    
    private var alarmIsOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    func updateViews() {
        guard let alarm = alarm
        else {
            title = "Add Alarm"
            return
        }
        title = "Edit Alarm"
        alarmFireDatePicker?.date = alarm.fireDate
        alarmTitleTextField?.text = alarm.title
        alarmIsOn = alarm.isEnabled
        updateIsEnabledButton()
    }
    
    func updateIsEnabledButton() {
        switch alarmIsOn {
        case true:
            alarmIsEnabledButton?.backgroundColor = .white
            alarmIsEnabledButton?.setTitle("On", for: .normal)
        case false:
            alarmIsEnabledButton?.backgroundColor = .systemGray5
            alarmIsEnabledButton?.setTitle("Off", for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let alarmTitle = alarmTitleTextField?.text,
              !alarmTitle.isEmpty,
              let fireDate = alarmFireDatePicker?.date
        else { return }
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm, title: alarmTitle, fireDate: fireDate, isEnabled: alarmIsOn)
        } else {
            AlarmController.shared.createAlarm(withTitle: alarmTitle, andFireDate: fireDate, isEnabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func alarmIsEnabledButtonTapped(_ sender: UIButton) {
        alarmIsOn.toggle()
        updateIsEnabledButton()
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleIsEnabled(for: alarm)
    }
}
