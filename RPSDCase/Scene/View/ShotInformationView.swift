//
//  ShotInformationView.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 4.06.2023.
//

import UIKit

class ShotInformationView: UIView {
    
    private var pointView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 50
        return view
    }()
    
    private var segmentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 50
        return view
    }()
    
    private var inOutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 50
        return view
    }()
    
    private var shotPosXView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 50
        return view
    }()
    
    private var shotPosYView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 50
        return view
    }()
    
    private var pointTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Point"
        return label
    }()
    
    private var segmentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Segment"
        return label
    }()
    
    private var inOutTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "In Out"
        return label
    }()
    
    private var shotPosXTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Shot Position X"
        return label
    }()
    
    private var shotPosYTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Shot Position Y"
        return label
    }()
    
    private(set) var pointLabel: UILabel!
    private(set) var segmentLabel: UILabel!
    private(set) var inOutLabel: UILabel!
    private(set) var shotPosXLabel: UILabel!
    private(set) var shotPosYLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubview(pointView)
        addSubview(segmentView)
        addSubview(inOutView)
        addSubview(shotPosXView)
        addSubview(shotPosYView)
        addSubviewLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviewLabels() {
        addSubview(pointTitleLabel)
        addSubview(segmentTitleLabel)
        addSubview(inOutTitleLabel)
        addSubview(shotPosXTitleLabel)
        addSubview(shotPosYTitleLabel)
        
        pointLabel = UILabel()
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.text = "Point"
        pointLabel.textAlignment = .center
        pointView.addSubview(pointLabel)
        pointLabel.centerXAnchor.constraint(equalTo: pointView.centerXAnchor).isActive = true
        pointLabel.centerYAnchor.constraint(equalTo: pointView.centerYAnchor).isActive = true
        
        segmentLabel = UILabel()
        segmentLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentLabel.text = "Segment"
        segmentLabel.textAlignment = .center
        segmentView.addSubview(segmentLabel)
        segmentLabel.centerXAnchor.constraint(equalTo: segmentView.centerXAnchor).isActive = true
        segmentLabel.centerYAnchor.constraint(equalTo: segmentView.centerYAnchor).isActive = true
        
        inOutLabel = UILabel()
        inOutLabel.translatesAutoresizingMaskIntoConstraints = false
        inOutLabel.text = "In/Out"
        inOutLabel.textAlignment = .center
        inOutView.addSubview(inOutLabel)
        inOutLabel.centerXAnchor.constraint(equalTo: inOutView.centerXAnchor).isActive = true
        inOutLabel.centerYAnchor.constraint(equalTo: inOutView.centerYAnchor).isActive = true
        
        shotPosXLabel = UILabel()
        shotPosXLabel.translatesAutoresizingMaskIntoConstraints = false
        shotPosXLabel.text = "Shot Pos X"
        shotPosXLabel.textAlignment = .center
        shotPosXView.addSubview(shotPosXLabel)
        shotPosXLabel.centerXAnchor.constraint(equalTo: shotPosXView.centerXAnchor).isActive = true
        shotPosXLabel.centerYAnchor.constraint(equalTo: shotPosXView.centerYAnchor).isActive = true
        
        shotPosYLabel = UILabel()
        shotPosYLabel.translatesAutoresizingMaskIntoConstraints = false
        shotPosYLabel.text = "Shot Pos Y"
        shotPosYLabel.textAlignment = .center
        shotPosYView.addSubview(shotPosYLabel)
        shotPosYLabel.centerXAnchor.constraint(equalTo: shotPosYView.centerXAnchor).isActive = true
        shotPosYLabel.centerYAnchor.constraint(equalTo: shotPosYView.centerYAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
            pointTitleLabel.centerXAnchor.constraint(equalTo: pointView.centerXAnchor),
            pointTitleLabel.topAnchor.constraint(equalTo: pointView.bottomAnchor, constant: 5),
            
            segmentTitleLabel.centerXAnchor.constraint(equalTo: segmentView.centerXAnchor),
            segmentTitleLabel.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 5),
            
            inOutTitleLabel.centerXAnchor.constraint(equalTo: inOutView.centerXAnchor),
            inOutTitleLabel.topAnchor.constraint(equalTo: inOutView.bottomAnchor, constant: 5),
            
            shotPosXTitleLabel.centerXAnchor.constraint(equalTo: shotPosXView.centerXAnchor),
            shotPosXTitleLabel.topAnchor.constraint(equalTo: shotPosXView.bottomAnchor, constant: 5),
            
            shotPosYTitleLabel.centerXAnchor.constraint(equalTo: shotPosYView.centerXAnchor),
            shotPosYTitleLabel.topAnchor.constraint(equalTo: shotPosYView.bottomAnchor, constant: 5)
        ])
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview!.widthAnchor, multiplier: 0.333),
            heightAnchor.constraint(equalTo: superview!.heightAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor),
            topAnchor.constraint(equalTo: superview!.topAnchor),
            
            pointView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pointView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pointView.widthAnchor.constraint(equalToConstant: 100),
            pointView.heightAnchor.constraint(equalToConstant: 100),
            
            segmentView.topAnchor.constraint(equalTo: pointView.bottomAnchor, constant: 50),
            segmentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentView.widthAnchor.constraint(equalToConstant: 100),
            segmentView.heightAnchor.constraint(equalToConstant: 100),
            
            inOutView.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 50),
            inOutView.centerXAnchor.constraint(equalTo: centerXAnchor),
            inOutView.widthAnchor.constraint(equalToConstant: 100),
            inOutView.heightAnchor.constraint(equalToConstant: 100),
            
            shotPosXView.topAnchor.constraint(equalTo: inOutView.bottomAnchor, constant: 50),
            shotPosXView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shotPosXView.widthAnchor.constraint(equalToConstant: 100),
            shotPosXView.heightAnchor.constraint(equalToConstant: 100),
            
            shotPosYView.topAnchor.constraint(equalTo: shotPosXView.bottomAnchor, constant: 50),
            shotPosYView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shotPosYView.widthAnchor.constraint(equalToConstant: 100),
            shotPosYView.heightAnchor.constraint(equalToConstant: 100)
        ])
        super.updateConstraints()
    }
}
