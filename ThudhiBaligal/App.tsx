import React, {useEffect} from 'react';
import {AppNavigator} from './src/navigation/AppNavigator';
import {useStore} from './src/store/useStore';

function App(): React.JSX.Element {
  const loadSettings = useStore(state => state.loadSettings);

  useEffect(() => {
    loadSettings();
  }, []);

  return <AppNavigator />;
}

export default App;
