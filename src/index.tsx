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

    /**
 * Options for initializing the Iubenda CMP SDK.
 */
    export interface hexIubendaOptions {
      siteId: string;
      googleAds?: boolean | null;
      gdprEnabled?: boolean | null;
      applyStyles?: boolean | null;
      forceConsent?: boolean | null;
      cookiePolicyId: string;
      cssContent?: string | null; // Consente null
      jsonContent?: string | null; // Consente null
      acceptIfDismissed?: boolean | null;
      skipNoticeWhenOffline?: boolean | null;
      preventDismissWhenLoaded?: boolean | null;
      csVersion?: string | null; // Consente null
      portraitWidth?: number | null; // Consente null
      portraitHeight?: number | null; // Consente null
      landscapeWidth?: number | null; // Consente null
      landscapeHeight?: number | null; // Consente null
      isFullScreen?: boolean | null;
      bannerPosition?: string | null; // Consente null
    }
    
    /**
     * Initializes the Iubenda CMP SDK.
     * @param options Options for the initialization.
     * @returns A promise that resolves on successful initialization.
     */
    export function initialize(userOptions: Partial<hexIubendaOptions>): Promise<string> {
      const defaultOptions: hexIubendaOptions = {
        siteId: '',
        cookiePolicyId: '',
        googleAds: null,
        gdprEnabled: null,
        applyStyles: true,
        forceConsent: null, // Default
        cssContent: null,
        jsonContent: null,
        acceptIfDismissed: null,
        skipNoticeWhenOffline: null,
        preventDismissWhenLoaded: null,
        csVersion: null,
        portraitWidth: null,
        portraitHeight: null,
        landscapeWidth: null,
        landscapeHeight: null,
        isFullScreen: null,
        bannerPosition: null,
      };
    
      // Sovrascrivi i default con le opzioni dell'utente
      const options: hexIubendaOptions = { ...defaultOptions, ...userOptions };
    
      if (!options.siteId || !options.cookiePolicyId) {
        throw new Error('siteId and cookiePolicyId are required for initialization.');
      }
    
      try {
        return HexIubenda.initialize(options);
      } catch (error) {
        console.error('Errore durante l\'inizializzazione:', error);
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