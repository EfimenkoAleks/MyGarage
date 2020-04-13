//
//  ExpandebleHeaderView.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ExpandebleHeaderViewDelegate {
    func toggleSection(header: ExpandebleHeaderView, section: Int)
}

class ExpandebleHeaderView: UITableViewHeaderFooterView {

    var delegate: ExpandebleHeaderViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, section: Int, delegate: ExpandebleHeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.textColor = .white
        contentView.backgroundColor = .darkGray
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        let cell = gesterRecognizer.view as! ExpandebleHeaderView
        delegate?.toggleSection(header: self, section: cell.section!)
    }
    
}

