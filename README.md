
# DocCheckAppLogin

The DocCheck App Login SDK provides you with a simple to use integration of the authentication through DocCheck. This is done by providing a ViewController which wraps the Web flow and handles callbacks for the authentication.

## Requirements

### Cordova

-

### iOS

- iOS 13.0+
- Xcode 12+
- Swift 5.0+

### Android

- Min SDK Version 26
- Kotlin Enabled
- AndroidX enabled

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

| Name           | Description|
|----------------|------------|
|login_id        | **DESCRIPTION MISSING**|
|code            | **DESCRIPTION MISSING**|
|state           | **DESCRIPTION MISSING**|
|dc_token        | **DESCRIPTION MISSING**|
|appid           | **DESCRIPTION MISSING**|
|intdclanguageid | **DESCRIPTION MISSING**|
|strdclanguage   | **DESCRIPTION MISSING**|
|uniquekey       | **DESCRIPTION MISSING**|
