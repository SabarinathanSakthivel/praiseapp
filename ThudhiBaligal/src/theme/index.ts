import {colors, darkColors} from './colors';

export const theme = {
  colors,
  spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  },
  borderRadius: {
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    round: 999,
  },
  fontSize: {
    xs: 12,
    sm: 14,
    md: 16,
    lg: 18,
    xl: 20,
    xxl: 24,
    xxxl: 32,
  },
  fontFamily: {
    regular: 'System',
    tamil: 'System', // Will use device's Tamil font
  },
};

export const darkTheme = {
  ...theme,
  colors: darkColors,
};

export type Theme = typeof theme;
