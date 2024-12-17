#import "HexIubenda.h"
#import "React/RCTLog.h"
#import <iubenda/iubenda-Swift.h>
@implementation HexIubenda
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
// RCT_EXPORT_METHOD(multiply:(double)a
//                   b:(double)b
//                   resolve:(RCTPromiseResolveBlock)resolve
//                   reject:(RCTPromiseRejectBlock)reject)
// {
//     NSNumber *result = @(a * b);

//     resolve(result);
// }

RCT_EXPORT_METHOD(initialize:(NSDictionary *)config
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    @try {
      IubendaCMPConfiguration *configuration = [[IubendaCMPConfiguration alloc] init];
      
      if ([config objectForKey:@"gdprEnabled"]) {
        configuration.gdprEnabled = [config objectForKey:@"gdprEnabled"];
      }
      
      if ([config objectForKey:@"forceConsent"]) {
        configuration.forceConsent = [config objectForKey:@"forceConsent"];
      }
      
      if ([config objectForKey:@"googleAds"]) {
        configuration.googleAds = [config objectForKey:@"googleAds"];
      }
      
      if ([config objectForKey:@"siteId"]) {
        configuration.siteId = [config objectForKey:@"siteId"];
      }
      
      if ([config objectForKey:@"cookiePolicyId"]) {
        configuration.cookiePolicyId = [config objectForKey:@"cookiePolicyId"];
      }
      
      if ([config objectForKey:@"cssContent"]) {
        configuration.cssContent = [config objectForKey:@"cssContent"];
      }
      
      if ([config objectForKey:@"jsonContent"]) {
        configuration.jsonContent = [config objectForKey:@"jsonContent"];
      }
      
      if ([config objectForKey:@"cssUrl"]) {
        configuration.cssUrl = [config objectForKey:@"cssUrl"];
      }
      
      if ([config objectForKey:@"applyStyles"]) {
        configuration.applyStyles = [config objectForKey:@"applyStyles"];
      }
      
      if ([config objectForKey:@"acceptIfDismissed"]) {
        configuration.acceptIfDismissed = [config objectForKey:@"acceptIfDismissed"];
      }
      
      if ([config objectForKey:@"skipNoticeWhenOffline"]) {
        configuration.skipNoticeWhenOffline = [config objectForKey:@"skipNoticeWhenOffline"];
      }
      
      if ([config objectForKey:@"preventDismissWhenLoaded"]) {
        configuration.preventDismissWhenLoaded = [config objectForKey:@"preventDismissWhenLoaded"];
      }
      
      if ([config objectForKey:@"csVersion"]) {
        configuration.csVersion = [config objectForKey:@"csVersion"];
      }
      
      if ([config objectForKey:@"proxyUrl"]) {
        configuration.proxyUrl = [config objectForKey:@"proxyUrl"];
      }
      
      if ([config objectForKey:@"portraitWidth"]) {
        configuration.portraitWidth = [[config objectForKey:@"portraitWidth"] integerValue];
      }
      
      if ([config objectForKey:@"portraitHeight"]) {
        configuration.portraitHeight = [[config objectForKey:@"portraitHeight"] integerValue];
      }
      
      if ([config objectForKey:@"landscapeWidth"]) {
        configuration.landscapeWidth = [[config objectForKey:@"landscapeWidth"] integerValue];
      }
      
      if ([config objectForKey:@"landscapeHeight"]) {
        configuration.landscapeHeight = [[config objectForKey:@"landscapeHeight"] integerValue];
      }
      
      [IubendaCMP initializeWith:configuration];
      
      // Se l'inizializzazione ha successo, risolvi la promessa
      resolve(@{ @"status": @"initialized successfully" });
    } @catch (NSException *exception) {
      // Se si verifica un'eccezione, rifiuta la promessa
      reject(@"initialize_error", @"Failed to initialize Iubenda CMP", nil);
    }
  });
}

RCT_EXPORT_METHOD(askConsent)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    @try {
      UIViewController *presentedViewController = RCTPresentedViewController();
      [IubendaCMP askConsentFrom:presentedViewController];
    }
    @catch (NSException *exception) {
      RCTLogError(@"Errore durante askConsent: %@", exception.reason);
    }
  });
}

RCT_EXPORT_METHOD(openPreferences)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    @try {
      UIViewController *presentedViewController = RCTPresentedViewController();
      [IubendaCMP openPreferencesFrom:presentedViewController];
    }
    @catch (NSException *exception) {
      RCTLogError(@"Errore durante openPreferences: %@", exception.reason);
    }
  });
}

RCT_EXPORT_METHOD(getConsentStatus: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  @try {
    // Recupera lo stato del consenso dai metodi disponibili
    NSMutableDictionary *consentStatus = [NSMutableDictionary new];
    
    // Esempio di utilizzo delle impostazioni disponibili
    consentStatus[@"consentString"] = [IubendaCMP.storage consentString];
    consentStatus[@"googlePersonalized"] = @([IubendaCMP.storage googlePersonalized]);
    
    //consentStatus[@"subjectToGDPR"] = @([IubendaCMP subjectToGDPR]);
    // consentStatus[@"cmpPresent"] = @([IubendaCMP.storage cmpPresent]);
    consentStatus[@"vendorConsents"] = [IubendaCMP.storage vendorConsents];
    consentStatus[@"purposeConsents"] = [IubendaCMP.storage purposeConsents];
    // consentStatus[@"consentTimestamp"] = @([IubendaCMP.storage consentTimestamp]);
    // consentStatus[@"preferenceExpressed"] = @([IubendaCMP.storage isPreferenceExpressed]);
    //consentStatus[@"isPurposeConsentGivenFor"] = @([IubendaCMP.storage isPurposeConsentGivenForPurposeId(1)]);
    // Risolve il risultato con lo stato del consenso
    NSData *data = [NSJSONSerialization dataWithJSONObject:consentStatus options:NSJSONWritingPrettyPrinted error:nil];

    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    resolve(jsonString);
  }
  @catch (NSException *exception) {
    NSString *errorMessage = [NSString stringWithFormat:@"getConsentStatus: Errore durante il recupero dello stato del consenso: %@", exception.reason];
    RCTLogError(@"%@", errorMessage);
    reject(@"get_consent_status_error", errorMessage, nil);
  }
}

@end