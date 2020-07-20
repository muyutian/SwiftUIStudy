//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by zhangzy on 2020/7/8.
//  Copyright © 2020 zhangzy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    /**
     定义按钮模型数组
     */
    let row: [ButtonItemModel] = [
           .digit(1), .digit(2), .digit(3), .op(.plus)
       ]
    
    var body: some View {
        /**
         初识了解stack和部分控件的布局应用
         注意属性的先后顺序
         */
        VStack (alignment: .leading){
            Text("VStack Text One")
                //.font(.title)
                .font(.custom("Copperplate", size: 30))
                //.foregroundColor(.green)
                .foregroundColor(Color(red: 25/255, green: 89/255, blue: 146/255))
            Text("VStack Text Two")
                .font(.subheadline)
            
//            Spacer()
//                .frame(height: 20)
            
            HStack (alignment: .center){
                Text("HStack Text One")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    
                Text("HStack Text Tow")
                    .font(.system(size: 14))
                
                Spacer()
                /**
                 注意渲染顺序
                 */
                Text("stop")
                    .font(.system(size: 14))
                    .foregroundColor(Color("yyy"))
                    .background(Color(Color.RGBColorSpace.sRGB, red: 32/255, green: 12/255, blue: 145/255, opacity: 1))
                    .padding(.horizontal, 20)
                    .background(Color.red)
            }
            
            .padding(.top, 20)
            
            /**
             了解button的创建初始化
             注意text属性以及渲染顺序
            */
            VStack (alignment: .center){
                Button(action: {
                    print("Button +")
                }){
                    Text("+")
                        .font(.system(size: 25))
                        .frame(width: 80, height: 80)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
            }
            
            .padding(.top, 20)
            
            /**
            加深对Stack堆叠的认识
            */
            HStack (alignment:.center) {
                ButtonView(title: "Btn 1",
                           size: CGSize(width: 60, height: 60),
                           bgColor: .yellow)
                {
                   print("按钮点击 1")
                }
                
                ButtonView(title: "Btn 2",
                           size: CGSize(width: 60, height: 60),
                           bgColor: .green)
                {
                   print("按钮点击 2")
                }
                
                ButtonView(title: "Btn 3",
                           size: CGSize(width: 60, height: 60),
                           bgColor: .blue)
                {
                   print("按钮点击 3")
                }
                
                ButtonView(title: "Btn 4",
                           size: CGSize(width: 60, height: 60),
                           bgColor: .red)
                {
                   print("按钮点击 4")
                }
            }
            
            .padding(.top, 20)
            
            /**
             通过swift数据模型创建控件
             ForEach 是 SwiftUI 中一个用来列举元素，并生成对应 View collection 的类型。它接受一个数组，且数组中的元素需要满足 Identifiable 协议
             */
            HStack (alignment:.center) {
                ForEach(row, id:\.self){item in
                    ButtonView(
                        title: item.title,
                        size: item.size,
                        bgColor: item.backgroundColor
                    ){
                            print("Button: \(item.title)")
                    }
                }
            }
            
            .padding(.vertical, 15)
            
            /**
             接下来可以将上述ForEach 代码抽象提取成View 只进行赋值row数组就可以
             这里Vstack中spacing是间距
             */
//            VStack(alignment: .center, spacing: 8){
//                ButtonItemRow(itemRow: [.command(.clear), .command(.flip),
//                .command(.percent), .op(.divide)])
//
//                ButtonItemRow(itemRow: [.digit(7), .digit(8), .digit(9), .op(.multiply)])
//
//                ButtonItemRow(itemRow: [.digit(4), .digit(5), .digit(6), .op(.minus)])
//
//                ButtonItemRow(itemRow: [.digit(1), .digit(2), .digit(3), .op(.plus)])
//
//                ButtonItemRow(itemRow: [.digit(0), .dot, .op(.equal)])
//            }
            
            /**
             又或者将上述代码二次提取会更简洁
             */
            ButtonItemPad()
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        //.padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 将Button抽象提取成为一个View
 */
struct ButtonView: View {
    
    let textSize: CGFloat = 17
    let title: String
    let size: CGSize
    let bgColor: Color
    let action: ()->Void
    
    var body: some View {
        Button(action:action){
            Text(title)
                .font(.system(size: textSize))
                .frame(width: size.width, height: size.height)
                .background(bgColor)
                .foregroundColor(.white)
                .cornerRadius(size.height/2)
        }
    }
}

/**
 接下来可以将上述ForEach 代码抽象提取成View
 只进行赋值row数组就可以
 */
struct ButtonItemRow: View {
    
    let itemRow: [ButtonItemModel]
    
    var body: some View {
        HStack (alignment:.center) {
            ForEach(itemRow, id:\.self){item in
                ButtonView(
                    title: item.title,
                    size: item.size,
                    bgColor: item.backgroundColor
                ){
                        print("Button: \(item.title)")
                }
            }
        }
    }
}


/**
 再次提取
 */
struct ButtonItemPad: View {
    
    let pad: [[ButtonItemModel]] = [
        [.command(.clear), .command(.flip),
        .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            ForEach(pad, id:\.self){row in
                ButtonItemRow(itemRow: row)
            }
        }
    }
    
}
