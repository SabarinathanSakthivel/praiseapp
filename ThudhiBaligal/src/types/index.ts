// Core types for the app
export interface Praise {
  id: number;
  praise: string;
}

export type PraiseCategoryType = 'MuzYut' | 'Bel' | 'NewBel';
export type LanguageType = 'tamil' | 'tanglish';

export interface PraiseCategory {
  id: number;
  name: string;
  englishName: string;
  type: PraiseCategoryType;
  count: number;
  color: string;
  icon: string;
}

export interface UserSettings {
  fontSize: number;
  fontFamily: string;
  fontColor: string;
  backgroundColor: string;
  darkMode: boolean;
}

export interface ReadingProgress {
  category: PraiseCategoryType;
  page: number;
  language: LanguageType;
}
