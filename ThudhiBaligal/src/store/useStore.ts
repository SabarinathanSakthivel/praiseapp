import {create} from 'zustand';
import {Praise, PraiseCategoryType, LanguageType, UserSettings} from '../types';

interface AppState {
  // Praises
  praises: Praise[];
  loading: boolean;
  currentCategory: PraiseCategoryType | null;
  currentLanguage: LanguageType;
  currentPage: number;

  // Settings
  settings: UserSettings;

  // Actions
  loadPraises: (category: PraiseCategoryType, language: LanguageType) => Promise<void>;
  setCurrentPage: (page: number) => void;
  toggleLanguage: () => void;
  updateSettings: (settings: Partial<UserSettings>) => Promise<void>;
  loadSettings: () => Promise<void>;
}

const defaultSettings: UserSettings = {
  fontSize: 18,
  fontFamily: 'System',
  fontColor: '#212121',
  backgroundColor: '#FFFFFF',
  darkMode: false,
};

export const useStore = create<AppState>((set, get) => ({
  praises: [],
  loading: false,
  currentCategory: null,
  currentLanguage: 'tamil',
  currentPage: 1,
  settings: defaultSettings,

  loadPraises: async (category: PraiseCategoryType, language: LanguageType) => {
    set({loading: true});
    try {
      const prefix = language === 'tamil' ? 'tam' : 'tan';
      const fileName = `${prefix}_praises_${category}.json`;

      // Dynamic import of JSON data
      let data: Praise[] = [];
      let jsonData: any;

      if (fileName === 'tam_praises_MuzYut.json') {
        jsonData = require('../assets/data/tam_praises_MuzYut.json');
      } else if (fileName === 'tan_praises_MuzYut.json') {
        jsonData = require('../assets/data/tan_praises_MuzYut.json');
      } else if (fileName === 'tam_praises_Bel.json') {
        jsonData = require('../assets/data/tam_praises_Bel.json');
      } else if (fileName === 'tan_praises_Bel.json') {
        jsonData = require('../assets/data/tan_praises_Bel.json');
      } else if (fileName === 'tam_praises_NewBel.json') {
        jsonData = require('../assets/data/tam_praises_NewBel.json');
      } else if (fileName === 'tan_praises_NewBel.json') {
        jsonData = require('../assets/data/tan_praises_NewBel.json');
      }

      // Extract the response array from the JSON data
      data = jsonData?.response || [];

      set({
        praises: data,
        currentCategory: category,
        currentLanguage: language,
        loading: false,
        currentPage: 1,
      });
    } catch (error) {
      console.error('Error loading praises:', error);
      set({loading: false, praises: []});
    }
  },

  setCurrentPage: (page: number) => set({currentPage: page}),

  toggleLanguage: () => {
    const {currentLanguage, currentCategory} = get();
    const newLanguage: LanguageType = currentLanguage === 'tamil' ? 'tanglish' : 'tamil';
    if (currentCategory) {
      get().loadPraises(currentCategory, newLanguage);
    }
  },

  updateSettings: async (newSettings: Partial<UserSettings>) => {
    const settings = {...get().settings, ...newSettings};
    set({settings});
    // Note: Settings will not persist between app restarts
    // AsyncStorage was removed due to build issues (JitPack server down)
    // Can be re-added later or replaced with alternative like react-native-mmkv
  },

  loadSettings: async () => {
    // Settings will use defaults from defaultSettings
    // Persistence can be added later when needed
  },
}));
