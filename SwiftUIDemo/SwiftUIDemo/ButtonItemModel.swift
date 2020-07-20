//
//  ButtonItemModel.swift
//  SwiftUIDemo
//
//  Created by zhangzy on 2020/7/9.
//  Copyright © 2020 zhangzy. All rights reserved.
//

import SwiftUI

/**
 枚举
 */
enum ButtonItemModel{
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case multiply = "x"
        case divide = "÷"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

/**
 获取其它属性
 */
extension ButtonItemModel {
    var title: String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }

    var size: CGSize {
        if case .digit(let value) = self, value == 0 {
            return CGSize(width: 54 * 2 + 8, height: 54)
        }
        return CGSize(width: 54, height: 54)
    }

    var backgroundColor: Color{
        switch self {
        case .digit, .dot: return .black
        case .op: return .orange
        case .command: return .gray
        }
    }
}


extension ButtonItemModel: Hashable {}
