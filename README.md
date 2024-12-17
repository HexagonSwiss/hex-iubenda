# hex-iubenda

Integration with iubenda SDK

## Installation

```sh
npm install hex-iubenda
```

```ios
## add in Podfile

source 'https://github.com/facebook/react-native.git'
source "https://github.com/iubenda/cocoapods.git"

pod 'IubendaMobileSDK', '2.8.3'

run pod install
```
```android
## add in app/build.gradle
repositories {
    maven { url "https://libraries.iubenda.com/android" }
}
dependencies {
    implementation "com.iubenda:mobile-sdk:2.6.7"
}

## Usage


```js
import {askConsent, openPreferences, initialize, getConsentStatus } from 'hex-iubenda'; 

const result = initialize(siteId, cookiePolicyId);

askConsent();

openPreferences();

const status = await getCStatus();
```


