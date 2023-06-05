//
//  CustomCell.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 4.06.2023.
//

import UIKit

class PlayerStatusCell: UITableViewCell {
    
    static let identifier = String(describing: PlayerStatusCell.self)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let segmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let inOutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let shotPosXLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let shotPosYLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(pointLabel)
        addSubview(segmentLabel)
        addSubview(inOutLabel)
        addSubview(shotPosXLabel)
        addSubview(shotPosYLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            pointLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            pointLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pointLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            segmentLabel.topAnchor.constraint(equalTo: pointLabel.bottomAnchor, constant: 10),
            segmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            inOutLabel.topAnchor.constraint(equalTo: segmentLabel.bottomAnchor, constant: 10),
            inOutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            inOutLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            shotPosXLabel.topAnchor.constraint(equalTo: inOutLabel.bottomAnchor, constant: 10),
            shotPosXLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shotPosXLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            shotPosYLabel.topAnchor.constraint(equalTo: shotPosXLabel.bottomAnchor, constant: 10),
            shotPosYLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shotPosYLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            shotPosYLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

    }
    
    func configureCellLabelText(name: String, userDatas: ShotRealm) {
        nameLabel.text = "Player: \(name)"
        pointLabel.text = "Point: \(userDatas.point)"
        segmentLabel.text = "Segment: \(userDatas.segment)"
        inOutLabel.text = "In Out: \(userDatas.inOut)"
        shotPosXLabel.text = "Shot Position X: \(userDatas.shotPosX)"
        shotPosYLabel.text = "Shot Position Y: \(userDatas.shotPosY)"
    }
}
