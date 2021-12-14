import UIKit

print("구구단 ")
for x in 2..<10{
    print("\(x)단")
    for i in 1..<10 {
        print("\(x) X \(i) = \(x*i)")
    }
}

//##################################

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Logger.d("open application \(url.absoluteString)")
        ///FaceBook 설정
    url.absoluteString
        ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
        
        /// 앱 호출 규격 이름이 "main"이 아닐 경우 제외, Glyde WebSite 외 다른 URL일 경우 제외,
        /// main URL 뒤에 스페이스가 들어 오는 경우가 있음. 트림 추가
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              let openURL = URL(string: components.queryItems?.first(where: { $0.name == "main"} )?.value?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""),
            let main = AppNaivigation.shared.rootViewController as? MainViewController,
            (openURL.host ?? "").hasSuffix(DEFAULT_HOST_SUFFIX)
            else { return false }
        
        DispatchQueue.main.async {
            main.baseWebURL = openURL
        }
        
        ///AppsFlayer 설정 - Open URI-scheme
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }
   
    // Report Push Notification attribution data for re-engagements
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        ///AppsFlayer 설정 : Open Universal Links
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        ///AppsFlayer 설정 - 유니버설 링크로 앱이 오픈, Reports app open from deep link for iOS 10 or late
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
