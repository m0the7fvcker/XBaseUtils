//
//  ViewController.swift
//  BaseUtils
//
//  Created by Poly.ma on 07/05/2018.
//  Copyright (c) 2018 Poly.ma. All rights reserved.
//

import UIKit
import XBaseUtils

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let str0 = "123456789"
        let str1 = str0.subString(from: 1, to: 5)
        let str2 = str0.subString(from: 0, length: 1)
        
        print(str1,str0,str2)

        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        btn.setImage(UIImage(named: "bill_copy"), for: .normal)
        btn.setTitle("按钮", for: .normal)
        
//        btn.setImageFrontTextWithTopAlignment(imageWidth: 60, space: 10)

        btn.setImageFrontTextWithCenterAlignment(imageWidth: 50, space: 1)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.enableTimeInterval = 3
//        btn.expandTouchArea = UIButtonExpandArea()
        view.addSubview(btn)
        let label = UILabel(title: "测试文字文字文字", titleFont: .systemFont(ofSize: 12), align: .center, color: .red)
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        label.sizeToFit()
        label.copyable = true
        view.addSubview(label)
        
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        view1.backgroundColor = .green
        view1.addGradientLayer(colors: [.red, .green])
        view1.modalShowInView(view, animated: true)
        
        
        let dic = ["name": "mark",
                   "age": "22",
                   "birth": "1999"]
        
        print(dic.jasonStirng())
        
        
        print(DeviceTool.shared.hardware())
    
    }
    
    @objc func btnClick() {
//        AuthorizationTool.turnOnAuthorizations()
        print("click")
    }


}

