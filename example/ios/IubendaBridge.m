#import "IubendaBridge.h"
#import "React/RCTLog.h"
#import <iubenda/iubenda-Swift.h>
@implementation IubendaBridge
// This RCT (React) "macro" exposes the current module to JavaScript
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(initialize: (NSDictionary *) config)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    
    @try{
      
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
      
    }
    @catch(NSException *exception){
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
    
    //consentStatus[@"subjectToGDPR"] = @([IubendaCMP.storage subjectToGDPR]);
    // consentStatus[@"cmpPresent"] = @([IubendaCMP.storage cmpPresent]);
    //consentStatus[@"vendorConsents"] = @([IubendaCMP.storage VendorConsents]);
    // consentStatus[@"purposeConsents"] = [IubendaCMP.storage PurposeConsents];
    // consentStatus[@"consentTimestamp"] = @([IubendaCMP.storage consentTimestamp]);
    // consentStatus[@"preferenceExpressed"] = @([IubendaCMP.storage isPreferenceExpressed]);
    //consentStatus[@"isPurposeConsentGivenFor(1)"] = [IubendaCMP.storage isPurposeConsentGivenFor(1)];
    // Risolve il risultato con lo stato del consenso
    resolve(consentStatus);
  }
  @catch (NSException *exception) {
    NSString *errorMessage = [NSString stringWithFormat:@"getConsentStatus: Errore durante il recupero dello stato del consenso: %@", exception.reason];
    RCTLogError(@"%@", errorMessage);
    reject(@"get_consent_status_error", errorMessage, nil);
  }
}
 
 
// // Metodo per verificare se il consenso è stato dato per uno scopo specifico
// RCT_EXPORT_METHOD(hasConsentForPurpose: (NSString *)purposeId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
// {
//   @try {
//     // Chiamata corretta al metodo isPurposeConsentGivenFor con il parametro purposeId
//     BOOL hasConsent = [IubendaCMP.storage isPurposeConsentGivenFor:[purposeId intValue]];
//     resolve(@(hasConsent));
//   }
//   @catch (NSException *exception) {
//     NSString *errorMessage = [NSString stringWithFormat:@"Errore durante la verifica del consenso per lo scopo %@: %@", purposeId, exception.reason];
//     RCTLogError(@"%@", errorMessage);
//     reject(@"has_consent_error", errorMessage, nil);
//   }
// }
 
@end