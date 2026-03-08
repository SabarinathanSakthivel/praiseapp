import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  ScrollView,
  StatusBar,
} from 'react-native';
import {theme} from '../theme';
import {PraiseCategoryType} from '../types';
import type {NativeStackNavigationProp} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../navigation/AppNavigator';

type DashboardScreenProps = {
  navigation: NativeStackNavigationProp<RootStackParamList, 'Dashboard'>;
};

const categories = [
  {
    id: 1,
    name: 'துதி பலிகள்',
    englishName: 'Main Praises',
    type: 'MuzYut' as PraiseCategoryType,
    count: 2400,
    color: theme.colors.category1,
    icon: '📖',
  },
  {
    id: 2,
    name: 'ஆவிக்குரிய ஆசீர்வாதம்',
    englishName: 'Spiritual Blessings',
    type: 'Bel' as PraiseCategoryType,
    count: 250,
    color: theme.colors.category2,
    icon: '✨',
  },
  {
    id: 3,
    name: 'விடுதலைக்காக',
    englishName: 'For Liberation',
    type: 'NewBel' as PraiseCategoryType,
    count: 300,
    color: theme.colors.category3,
    icon: '🕊',
  },
];

export const DashboardScreen: React.FC<DashboardScreenProps> = ({navigation}) => {
  const handleCategoryPress = (category: typeof categories[0]) => {
    navigation.navigate('PraiseReading', {
      category: category.type,
      categoryName: category.name,
    });
  };

  return (
    <View style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor={theme.colors.background} />

      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>துதி பலிகள்</Text>
        <Text style={styles.subtitle}>Thudhi Baligal</Text>
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Categories Title */}
        <Text style={styles.sectionTitle}>Categories</Text>

        {/* Category Cards */}
        <View style={styles.categoriesGrid}>
          {categories.map(category => (
            <TouchableOpacity
              key={category.id}
              style={[styles.categoryCard, {backgroundColor: category.color}]}
              onPress={() => handleCategoryPress(category)}
              activeOpacity={0.8}>
              <Text style={styles.categoryIcon}>{category.icon}</Text>
              <Text style={styles.categoryName}>{category.name}</Text>
              <Text style={styles.categoryEnglishName}>{category.englishName}</Text>
              <Text style={styles.categoryCount}>{category.count}+ Praises</Text>
            </TouchableOpacity>
          ))}
        </View>

        {/* About Section */}
        <View style={styles.aboutSection}>
          <Text style={styles.aboutText}>
            A digital prayer book containing thousands of Tamil Christian praises and worship texts.
          </Text>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
  header: {
    paddingTop: theme.spacing.xl,
    paddingBottom: theme.spacing.lg,
    paddingHorizontal: theme.spacing.md,
    backgroundColor: theme.colors.background,
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border,
  },
  title: {
    fontSize: theme.fontSize.xxxl,
    fontWeight: 'bold',
    color: theme.colors.textPrimary,
    marginBottom: theme.spacing.xs,
  },
  subtitle: {
    fontSize: theme.fontSize.md,
    color: theme.colors.textSecondary,
  },
  content: {
    flex: 1,
    paddingHorizontal: theme.spacing.md,
  },
  sectionTitle: {
    fontSize: theme.fontSize.xl,
    fontWeight: '600',
    color: theme.colors.textPrimary,
    marginTop: theme.spacing.lg,
    marginBottom: theme.spacing.md,
  },
  categoriesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  categoryCard: {
    width: '48%',
    aspectRatio: 1,
    borderRadius: theme.borderRadius.lg,
    padding: theme.spacing.md,
    marginBottom: theme.spacing.md,
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: {width: 0, height: 2},
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  categoryIcon: {
    fontSize: 48,
    marginBottom: theme.spacing.sm,
  },
  categoryName: {
    fontSize: theme.fontSize.md,
    fontWeight: 'bold',
    color: '#FFFFFF',
    textAlign: 'center',
    marginBottom: theme.spacing.xs,
  },
  categoryEnglishName: {
    fontSize: theme.fontSize.xs,
    color: 'rgba(255,255,255,0.9)',
    textAlign: 'center',
    marginBottom: theme.spacing.xs,
  },
  categoryCount: {
    fontSize: theme.fontSize.sm,
    color: 'rgba(255,255,255,0.8)',
    textAlign: 'center',
  },
  aboutSection: {
    marginTop: theme.spacing.lg,
    marginBottom: theme.spacing.xl,
    padding: theme.spacing.md,
    backgroundColor: theme.colors.surface,
    borderRadius: theme.borderRadius.md,
  },
  aboutText: {
    fontSize: theme.fontSize.sm,
    color: theme.colors.textSecondary,
    textAlign: 'center',
    lineHeight: 20,
  },
});
