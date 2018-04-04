//
//  AppConfig.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

//MARK:- 全局公用属性
public let kStatusBarH: CGFloat = UIApplication.shared.statusBarFrame.size.height
public let kNaviBarH: CGFloat = 44
public let kTopH: CGFloat = kStatusBarH + kNaviBarH
public let KTabbarH: CGFloat = AppDelegate.tabBarContoller.tabBar.frame.height
public let KBottomH: CGFloat = Device.Size() == .iPhoneX ? KTabbarH + 34: KTabbarH

/// 主机地址
public let AppHostIP = "http://appapi2.gamersky.com"
public let IHostIP = "http://i.gamersky.com"
/// 系统版本
public let osVersion = UIDevice.current.systemVersion
/// 设备 ID
public let deviceID = UIDevice.current.identifierForVendor!.uuidString


// MARK: -- 颜色

public let MainColor = RGB(233, g: 50, b: 56)

/// RGB
func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return RGBA(r, g: g, b: b, a: 1.0)
}

/// RGBA
func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//MARK:- 字体
let PFM20Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 20)!
let PFM18Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 18)!
let PFM16Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 16)!
let PFM15Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 15)!
let PFM14Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 14)!
let PFM13Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 13)!
let PFM12Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 12)!
let PFM11Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 11)!
let PFM10Font: UIFont = UIFont(name: "PingFangSC-Medium", size: 10)!

let PFR20Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 20)!
let PFR18Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 18)!
let PFR16Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 16)!
let PFR15Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 15)!
let PFR14Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 14)!
let PFR13Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 13)!
let PFR12Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 12)!
let PFR11Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 11)!
let PFR10Font: UIFont = UIFont(name: "PingFangSC-Regular", size: 10)!
