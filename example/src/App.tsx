import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Button } from 'react-native';
import { askConsent as askC, openPreferences as openP, initialize, getConsentStatus as getCStatus } from 'hex-iubenda';

const App = () => {
  const [initialized, setInitialized] = useState(false);
  const [consentStatus, setConsentStatus] = useState('');

  // Inizializzazione
  useEffect(() => {
    const result = initialize('3782169', '66406702');
    setInitialized(result);
  }, []); // L'array vuoto assicura che l'inizializzazione avvenga solo una volta, simile a componentDidMount

  // Funzioni per interagire con l'SDK
  const askConsent = () => {
    askC();
  };

  const openPreference = () => {
    openP();
  };

  const consentString = async () => {
    try {
      const status = await getCStatus();
      setConsentStatus(status);
    } catch (error) {
      console.error('Errore durante il recupero dello stato del consenso:', error);
      setConsentStatus('Errore nel recupero del consenso');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>SDK Iubenda</Text>
      <Text style={styles.status}>
        {initialized ? 'Inizializzato.' : 'Inizializzazione in corso...'}
      </Text>
      <Button title="Mostra Consenso" onPress={askConsent} />
      <Button title="Apri Preferenze" onPress={openPreference} />
      <Button title="Mostra consent string" onPress={consentString} />
      {consentStatus && <Text style={styles.status}>Consenso: {consentStatus}</Text>}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  status: {
    fontSize: 16,
    color: '#666',
  },
  consentString: {
    fontSize: 16,
    color: '#333',
    marginTop: 20,
  },
});

export default App;
