//
//  tableCell.swift
//  Bicycall
//
//  Created by Jamil Joo on 9/1/2021.
//
import Foundation
import UIKit

class tableCell: UITableViewCell{
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
}
