import DocCheckAppLoginSDK

/*
* Notes: The @objc shows that this class & function should be exposed to Cordova.
*/
@objc(DocCheckAppLogin) class DocCheckAppLogin : CDVPlugin {
    
  var callbackId = ""
  @objc(openLogin:)
  func openLogin(command: CDVInvokedUrlCommand) { 
    self.callbackId = command.callbackId
    
    
    guard
        let loginId = command.argument(at: 0, withDefault: "") as? String,
        !loginId.isEmpty
    else {
        let status = CDVCommandStatus_ERROR
        let message = "Cant use DocCheckAppLogin without a loginId"
        let result = CDVPluginResult(status: status, messageAs: message)
        
        self.commandDelegate?.send(result, callbackId: self.callbackId);
        return
    }
    
    let language: String
    if let lng = command.argument(at: 1, withDefault: "de") as? String {
        language = lng
    }
    else {
        language = "de"
    }
    
    let templateName: String
    if let tn = command.argument(at: 2, withDefault: "s_mobile") as? String {
        templateName = tn
    }
    else {
        templateName = "s_mobile"
    }
    
    // init viewcontroller
    let vc = DocCheckLogin(
        with: loginId,
        language: language,
        templateName: templateName
    )
    
    // assign callbacks
    vc.loginSuccesful = docCheckLoginSuccessful
    vc.loginFailed = docCheckLoginFailedWithError(_:)
    vc.loginCanceled = docCheckLoginCanceled
    vc.receivedUserInformations = docCheckLoginReceivedUserInfo(_:)
    
    self.viewController.present(vc, animated: true)
  }
    
    
    func docCheckLoginSuccessful() {
        print("login succesful")
        let status = CDVCommandStatus_OK
        var resultDict: [AnyHashable : Any] = [:]
        resultDict["success"] = "1"
        resultDict["message"] = "login succeeded"
        let result = CDVPluginResult(status: status, messageAs: resultDict)
        result?.setKeepCallbackAs(true)
        
        self.commandDelegate?.send(result, callbackId: self.callbackId);
    }
    
    func docCheckLoginFailedWithError(_ error: DocCheckLoginError!) {
        print("login failed with error: \(String(describing: error))")
        let status = CDVCommandStatus_ERROR
        var resultDict: [AnyHashable : Any] = [:]
        resultDict["success"] = "0"
        resultDict["message"] = "login failed with error: \(String(describing: error))"
        let result = CDVPluginResult(status: status, messageAs: resultDict)
        
        self.commandDelegate?.send(result, callbackId: self.callbackId);
    }
    
    func docCheckLoginCanceled(){
        print("login canceled")
        let status = CDVCommandStatus_ERROR
        var resultDict: [AnyHashable : Any] = [:]
        resultDict["success"] = "0"
        resultDict["message"] = "user canceled the login"
        let result = CDVPluginResult(status: status, messageAs: resultDict)
        
        self.commandDelegate?.send(result, callbackId: self.callbackId);
    }
    
    func docCheckLoginReceivedUserInfo(_ userInfo: [AnyHashable : Any]? = [:]) {
        let status = CDVCommandStatus_OK
        var resultDict: [AnyHashable : Any] = [:]
        resultDict["success"] = "1"
        resultDict["message"] = "received user information"
        
        guard let userInfo = userInfo else {
            let result = CDVPluginResult(status: status, messageAs: resultDict)
            self.commandDelegate?.send(result, callbackId: self.callbackId);
            return
        }
        
        resultDict["data"] = userInfo
        
        let result = CDVPluginResult(status: status, messageAs: resultDict)
        result?.setKeepCallbackAs(true)
        self.commandDelegate?.send(result, callbackId: self.callbackId);
    }
}

