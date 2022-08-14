//
//  IntraZeroTaskApp.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    return true
  }
}
@main
struct IntraZeroTaskApp: App {
    let  persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SplachScreenView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase{
                //TODO: save in background
            case .background:
                print("Scene is in background")
                persistenceController.save()
                
            case .inactive:
                print("Scene is in inactive")

            case .active:
                print("Scene is in active")

            @unknown default:
                print("Scene is in default")

            }
        }
    }
}
