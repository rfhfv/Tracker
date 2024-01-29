//
//  ScheduleCell.swift
//  Tracker
//
//  Created by admin on 25.12.2023.
//

import UIKit

protocol ScheduleCellDelegate: AnyObject {
    func didToogleSwitch(for day: String, switchActive: Bool)
}

final class ScheduleCell: UITableViewCell {
    weak var delegate: ScheduleCellDelegate?
    
    // MARK: - UIElements
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blackDay
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var switchDay: UISwitch = {
        let switchDay = UISwitch()
        switchDay.onTintColor = .blueYP
        switchDay.translatesAutoresizingMaskIntoConstraints = false
        switchDay.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        return switchDay
    }()
    
    private lazy var uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundDay
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scheduleLabel)
        view.addSubview(switchDay)
        view.addSubview(switchDay)
        NSLayoutConstraint.activate([
            scheduleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            scheduleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            switchDay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            switchDay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            switchDay.heightAnchor.constraint(equalToConstant: 31),
            switchDay.widthAnchor.constraint(equalToConstant: 51),
        ])
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configViews()
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Action
    
    @objc func switchAction(_ sender: UISwitch) {
        guard let nameDay = scheduleLabel.text else { return }
        if switchDay.isOn {
            delegate?.didToogleSwitch(for: nameDay, switchActive: true)
        } else {
            delegate?.didToogleSwitch(for: nameDay, switchActive: false)
        }
    }
    
    // MARK: - Methods
    
    func configureCell(with text: String, isSwitchOn: Bool, cellIndex: Int, numberOfLines: Int) {
        scheduleLabel.text = text
        switchDay.setOn(isSwitchOn, animated: true)
        roundingForCellsInATable(cellIndex: cellIndex, numberOfLines: numberOfLines)
    }
    
    // MARK: - Privatr methods
    
    private func roundingForCellsInATable(cellIndex: Int, numberOfLines: Int) {
        switch (cellIndex, numberOfLines) {
        case (0,1):
            uiView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case (0, _):
            uiView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (_, _) where cellIndex == numberOfLines - 1:
            uiView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            uiView.layer.maskedCorners = []
        }
    }
    
    private func configViews() {
        contentView.addSubview(uiView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: contentView.topAnchor),
            uiView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            uiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
