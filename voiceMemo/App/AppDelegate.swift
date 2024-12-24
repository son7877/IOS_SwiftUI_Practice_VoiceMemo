//
//  AppDelegate.swift
//  voiceMemo
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate{ // NSObject: Objective-C의 클래스를 상속받아 사용할 수 있게 해주는 클래스
    var notificationDelegate = NotificationDelegate()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            UNUserNotificationCenter.current().delegate = notificationDelegate
            return true
    }
  
}
