import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {DashboardScreen} from '../screens/DashboardScreen';
import {PraiseReadingScreen} from '../screens/PraiseReadingScreen';
import {SettingsScreen} from '../screens/SettingsScreen';
import {PraiseCategoryType} from '../types';
import {theme} from '../theme';

export type RootStackParamList = {
  Dashboard: undefined;
  PraiseReading: {
    category: PraiseCategoryType;
    categoryName: string;
  };
  Settings: undefined;
};

const Stack = createNativeStackNavigator<RootStackParamList>();

export const AppNavigator = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator
        initialRouteName="Dashboard"
        screenOptions={{
          headerStyle: {
            backgroundColor: theme.colors.background,
          },
          headerTintColor: theme.colors.textPrimary,
          headerTitleStyle: {
            fontWeight: 'bold',
            fontSize: theme.fontSize.lg,
          },
        }}>
        <Stack.Screen
          name="Dashboard"
          component={DashboardScreen}
          options={{
            headerShown: false,
          }}
        />
        <Stack.Screen
          name="PraiseReading"
          component={PraiseReadingScreen}
          options={{
            headerBackTitleVisible: false,
          }}
        />
        <Stack.Screen
          name="Settings"
          component={SettingsScreen}
          options={{
            title: 'Settings',
          }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};
