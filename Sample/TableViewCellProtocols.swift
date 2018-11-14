//
//  TableViewCellProtocols.swift
//  TouchTunesTest
//
//  Created by Morteza on 10/30/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView{
    
    func register<T: UITableViewCell> (_: T.Type) where  T:NibLoadableView {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell <T :UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath ) as? T else {
            fatalError("coudnot load cell with \(T.reuseIdentifier)")
        }
        return cell
    }
    
    
}

extension ToDoTableViewCell: NibLoadableView{}

