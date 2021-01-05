//
//  SectionHeader.swift
//  MyGarage
//
//  Created by mac on 18.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseId = "SectionHeader"
    let title = UILabel()
    let viewLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customizeElement()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(title)
        addSubview(viewLine)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            viewLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewLine.heightAnchor.constraint(equalToConstant: 1),
            viewLine.widthAnchor.constraint(equalToConstant: self.bounds.size.width / 3 * 2)
        ])
    }
    
    private func customizeElement() {
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        viewLine.backgroundColor = .black
        viewLine.translatesAutoresizingMaskIntoConstraints = false
    }
}
