 import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'hex-iubenda' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const HexIubenda = NativeModules.HexIubenda
  ? NativeModules.HexIubenda
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

// export function multiply(a: number, b: number): Promise<number> {
//   return HexIubenda.multiply(a, b);
// }


  export function initialize(siteId: string, cookiePolicyId: string): boolean {
    const config = {
      gdprEnabled: true,
      forceConsent: true,
      siteId: siteId,
      cookiePolicyId: cookiePolicyId,
    };
    try{
      HexIubenda.initialize(config);
      return true;
    }
    catch(error){
      console.error("Errore durante l'inizializzazione:", error);
      throw error;
    }
  }

  export function askConsent() {
    HexIubenda.askConsent();
  }

  export function openPreferences() {
    HexIubenda.openPreferences();
  }

  export async function getConsentStatus() {
    try {
      const status = HexIubenda.getConsentStatus();
      console.log('Stato del consenso:', status);
      return status;
    } catch (error) {
      console.error('Errore durante il recupero dello stato del consenso:', error);
      throw error;
    }
  }