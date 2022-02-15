//
//  BasePaddingLabel.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/15.
//

import UIKit
class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
