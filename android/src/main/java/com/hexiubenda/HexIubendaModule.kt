package com.hexiubenda

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.google.gson.Gson
import com.iubenda.iab.IubendaCMP
import com.iubenda.iab.IubendaCMPConfig

class HexIubendaModule(reactContext: ReactApplicationContext) :
        ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return NAME
    }


    @ReactMethod
    fun initialize(configMap: ReadableMap, promise: Promise) {
        try{
        val context = reactApplicationContext
        val builder = IubendaCMPConfig.builder()
        if (hasValidKey("gdprEnabled", configMap))
                builder.gdprEnabled(configMap.getBoolean("gdprEnabled"))
        if (hasValidKey("forceConsent", configMap))
                builder.forceConsent(configMap.getBoolean("forceConsent"))
        if (hasValidKey("googleAds", configMap))
                builder.googleAds(configMap.getBoolean("googleAds"))
        if (hasValidKey("siteId", configMap)) builder.siteId(configMap.getString("siteId"))
        if (hasValidKey("cookiePolicyId", configMap))
                builder.cookiePolicyId(configMap.getString("cookiePolicyId"))
        if (hasValidKey("cssContent", configMap))
                builder.cssContent(configMap.getString("cssContent"))
        if (hasValidKey("jsonContent", configMap))
                builder.jsonContent(configMap.getString("jsonContent"))
        if (hasValidKey("cssUrl", configMap)) builder.cssUrl(configMap.getString("cssUrl"))
        if (hasValidKey("applyStyles", configMap))
                builder.applyStyles(configMap.getBoolean("applyStyles"))
        if (hasValidKey("acceptIfDismissed", configMap))
                builder.acceptIfDismissed(configMap.getBoolean("acceptIfDismissed"))
        if (hasValidKey("skipNoticeWhenOffline", configMap))
                builder.skipNoticeWhenOffline(configMap.getBoolean("skipNoticeWhenOffline"))
        if (hasValidKey("preventDismissWhenLoaded", configMap))
                builder.preventDismissWhenLoaded(configMap.getBoolean("preventDismissWhenLoaded"))
        if (hasValidKey("csVersion", configMap)) builder.csVersion(configMap.getString("csVersion"))
        if (hasValidKey("proxyUrl", configMap)) builder.proxyUrl(configMap.getString("proxyUrl"))
        if (hasValidKey("portraitWidth", configMap))
                builder.portraitWidth(configMap.getInt("portraitWidth"))
        if (hasValidKey("portraitHeight", configMap))
                builder.portraitHeight(configMap.getInt("portraitHeight"))
        if (hasValidKey("landscapeWidth", configMap))
                builder.landscapeWidth(configMap.getInt("landscapeWidth"))
        if (hasValidKey("landscapeHeight", configMap))
                builder.landscapeHeight(configMap.getInt("landscapeHeight"))
        val config = builder.build()
        IubendaCMP.initialize(context, config)

        promise.resolve(true)
        } catch (e: Exception) {
            promise.reject("Error", e)
        }
    }

    fun hasValidKey(key: String, options: ReadableMap?): Boolean {
        return options != null && options.hasKey(key) && !options.isNull(key)
    }

    @ReactMethod
    fun askConsent() {
        val activity = currentActivity
        IubendaCMP.askConsent(activity)
    }

    @ReactMethod
    fun openPreferences() {
        val activity = currentActivity
        IubendaCMP.openPreferences(activity)
    }

    @ReactMethod
    fun getConsentStatus(): String {
        val consentStatus = mutableMapOf<String, Any?>()
        // Recupera lo stato del consenso dai metodi disponibili
        val storage = IubendaCMP.getStorage()
        consentStatus["consentString"] = storage.getConsentString()//Return the consent string
        consentStatus["googlePersonalized"] = storage.isGooglePersonalized();//True if user have accepted the Google Personalized ADs option
        consentStatus["vendorConsents"] = storage.getVendorsString()//Returns the vendors binary String
        consentStatus["purposeConsents"] = storage.getPurposesString()//Returns the purposes binary String
        consentStatus["consentTimestamp"] = storage.getConsentTimestamp()//Returns the timestamp of the consent

        // Risolve il risultato con lo stato del consenso
        val gson = Gson()
        return gson.toJson(consentStatus)
    }

    companion object {
        const val NAME = "HexIubenda"
    }
}
