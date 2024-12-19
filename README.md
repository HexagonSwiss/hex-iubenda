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
import {askConsent, openPreferences, initialize, getConsentStatus, type hexIubendaOptions  } from 'hex-iubenda'; 

const options: hexIubendaOptions = {
    siteId: siteId,
    cookiePolicyId: cookiePolicyId,
    ,
    ,
  };

 useEffect(() => {
    initialize(options).then(result => {
      if (result) {
        setInitialized(true); // Set to true if initialization is successful
      }
    })
    .catch(error => {
      console.error("Initialization failed:", error);
      setInitialized(false); // Make sure it stays false in case of an error
    });
  }, []);

askConsent();

openPreferences();

getCStatus();
```

##Settings

# Impostazioni Iubenda

| **Setting**                | **Default**      | **Description**                                                                                                                                                                   |
|----------------------------|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `csVersion`                | `current`        | Defines which version of the Privacy Controls and Cookie Solution to use. Accepted values are `current`, `beta`, `stable`, or a specific version number.                          |
| `gdprEnabled`              | `false`          | Proxy for IAB TCF’s `IABConsent_SubjectToGDPR` setting. If `false`, Mediation SDK can run mediation across all ad network SDKs. If `true`, it runs only among GDPR-ready SDKs.    |
| `siteId`                   |                  | ID of the customer’s site on Iubenda.                                                                                                                                             |
| `cookiePolicyId`           |                  | ID of the customer’s Cookie Policy on Iubenda.                                                                                                                                    |
| `googleAds`                | `false`          | Enables consent management for Google personalized ads if set to `true`.                                                                                                          |
| `jsonContent`              |                  | Same as `jsonFile`, but set as a string.                                                                                                                                          |
| `forceConsent`             | `true`           | If `true`, the consent screen will be presented until consent is granted. If `false`, `askConsent()` won’t work if the user dismisses the consent request after the first launch. |               
| `cssContent`               |                  | Same as `cssFile`, but set as a string.                                                                                                                                           |
| `acceptIfDismissed`        | `false`          | If `true`, dismissing the popup results in accepting the notice (if the JS is ready).                                                                                             |
| `preventDismissWhenLoaded` | `false`          | If `true`, the popup cannot be dismissed without expressing a preference after it is fully loaded.                                                                                |
| `skipNoticeWhenOffline`    | `true`           | If enabled, `askConsent()` will not show the popup if no internet connection is detected.                                                                                         |
| `landscapeHeight`          |                  | Custom height for the first layer in landscape mode.                                                                                                                              |
| `landscapeWidth`           |                  | Custom width for the first layer in landscape mode.                                                                                                                               |
| `portraitHeight`           |                  | Custom height for the first layer in portrait mode.                                                                                                                               |
| `portraitWidth`            |                  | Custom width for the first layer in portrait mode.                                                                                                                                |
| `isFullScreen`             | `false`          | Sets full width and height for all layers if `true`.                                                                                                                              |
| `applyStyles`              | `true`           | If `true`, the standard CSS style is applied to the consent UI.                                                                                                                   |
| `isFullScreen`             | `false`          | Sets full width and height for all layers if `true`.                                                                                                                              |
| `bannerPosition`           | `center`         | Sets the position of the Consent Banner Pop-Up to `top`, `bottom`, or `center`.                                                                                                   |

