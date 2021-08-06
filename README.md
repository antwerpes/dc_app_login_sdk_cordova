
# DocCheckAppLogin

The DocCheck App Login SDK provides you with a simple to use integration of the authentication through DocCheck. This is done by providing a ViewController which wraps the Web flow and handles callbacks for the authentication.

For more details regarding the DocCheck login product and licenses visit [our website](https://more.doccheck.com/en/industry/) or request initial information via industry@doccheck.com.

## Requirements

### Cordova

-

### iOS

- iOS 11.0+
- Xcode 12+
- Swift 5.0+

### Android

- Min SDK Version 26
- Kotlin Enabled
- AndroidX enabled

### DocCheck Login ID

In order to ensure smooth integration and functioning always adhere to using the respective framework. Before you can implement the DocCheck Login in your app, you will need to set up a new login in CReaM (<http://crm.doccheck.com/com/>). For detailed instructions please read the technical handbook in the download section of <https://more.doccheck.com/en/industry/> (chapter 2.2.3). When a new login has been created, please add the bundle identifier (for iOS) or the package name (for Android) in the destination URL. This process in general runs as follows: topleveldomain.companyname.appname

Example for input in the target URL in CReaM:

```shell
doccheck://login?appid=bundleidentifier
```

### DocCheck License

For mobile applications a mobile license is required.To get more details about the different packages (basic, economy and business) as well as booking process please contact industry@doccheck.com.  

## Installation

### Cordova CLI

Using the the cordova cli the installation is done by using the git url like this.

```shell
cordova plugin add https://github.com/antwerpes/dc_app_login_sdk_cordova.git
```

### Ionic CLI

As the ionic cli is only wrapping the cordova cli there is not much of a difference.

```shell
ionic cordova plugin add 
```

### Config.xml

After the plugin was added the `config.xml` needs to be adjusted to fulfill the requirements of the plugin for each platform.

```xml
    <!-- ios -->
    <preference name="SwiftVersion" value="5.0" />
    <preference name="deployment-target" value="13.0" />
    <!-- android -->
    <preference name="GradlePluginKotlinEnabled" value="true" />
    <preference name="AndroidXEnabled" value="true" />
    <preference name="android-minSdkVersion" value="26" />
```

## Usage

The plugin offers a simple openLogin function with callbacks that can be integrated as shown below with an angular based example.

```typescript
declare let DocCheckAppLogin: any; // to be able to use the cordova plugin

export class YourComponent {

    exampleFunction() {
        DocCheckAppLogin.openLogin(
            result => {
                // do something on success
                // result['success'] should be '1'
                // result['data'] should hold additional values
            },
            result => {
                // do something on failure or cancel
                // result['success'] should be '0'
            },
            "YOUR_LOGIN_ID",
            "YOUR_SELECTED_LANGUAGE", // optional will default to de
            "TEMPLATE_NAME" // optional will default to s_mobile
        );
    }
}
```

## Example

An example project with integration instructions can be found in the [Example Repository](https://github.com/antwerpes/dc_app_login_sdk_cordova_example)

## Response Parameters

| Name           |Status   |Description                                                                | Value                                                               | License Type     |
|----------------|---------|---------------------------------------------------------------------------|---------------------------------------------------------------------|------------------|
|login_id        |internal |login ID associated with the login                                         |e.g. 200000012345                                                    |all               |
|appid           |internal |bundle identifier for the current app, is related to the mobile special    |e.g. "bundleidentifier"                                              |all         |
|intdclanguageid |internal |internal ID that tracks the user language                                  |e.g. 148                                                             |all               |
|strDcLanguage   |internal |iso code that tracks the user language                                     |(for Personal form). One of "de", "en"/"com", "fr", "nl", "it", "es".|all               |
|uniquekey       |valid    |alphanumerical string that is individual per user, is passed by each login |e.g. abc_abc884e739adf439ed521720acb5b232                            |economy + business|
|code            |valid    |Oauth2 parameter                                                           |e.g. abc884e739adf439ed521720acb5b232abc884e739adf439ed521720acb5b232|economy + business|
|state           |valid    |Oauth2 parameter                                                           |e.g. eHxI902CC3doao1                                                 |economy + business|
|dc_agreement    |valid    |status of confirmation of the data transfer consent form                   |0 = not confirmed; 1 = confirmed                                     |business          |

Please note that additional parameters can be delivered in case of valid consent for data transfer in combination with an implemented business license. For more Details, please check the OAuth2 documentation. Thats one can be reuqested via industry@doccheck.com.
