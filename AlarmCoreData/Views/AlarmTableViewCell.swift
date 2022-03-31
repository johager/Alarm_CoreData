//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func isEnabledSwitchToggled(in cell: AlarmTableViewCell)
}

// MARK: -

class AlarmTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    // MARK: - Properties
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    // MARK: - View Methods
    
    func configure(with alarm: Alarm, andDelegate delegate: AlarmTableViewCellDelegate) {
        alarmTitleLabel?.text = alarm.title
        alarmFireDateLabel?.text = alarm.fireDate.asFireDateString
        isEnabledSwitch?.isOn = alarm.isEnabled
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @IBAction func isEnabledSwitchToggled(_ sender: UISwitch) {
        delegate?.isEnabledSwitchToggled(in: self)
    }
}
