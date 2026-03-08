import React, {useEffect, useState} from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  ActivityIndicator,
  StatusBar,
} from 'react-native';
import {theme} from '../theme';
import {useStore} from '../store/useStore';
import type {RouteProp} from '@react-navigation/native';
import type {NativeStackNavigationProp} from '@react-navigation/native-stack';
import type {RootStackParamList} from '../navigation/AppNavigator';

type PraiseReadingScreenProps = {
  navigation: NativeStackNavigationProp<RootStackParamList, 'PraiseReading'>;
  route: RouteProp<RootStackParamList, 'PraiseReading'>;
};

const PRAISES_PER_PAGE = 20;

export const PraiseReadingScreen: React.FC<PraiseReadingScreenProps> = ({
  navigation,
  route,
}) => {
  const {category, categoryName} = route.params;
  const {
    praises,
    loading,
    currentPage,
    currentLanguage,
    settings,
    loadPraises,
    setCurrentPage,
    toggleLanguage,
  } = useStore();

  const [currentPageData, setCurrentPageData] = useState<typeof praises>([]);

  useEffect(() => {
    navigation.setOptions({
      title: categoryName,
    });
    loadPraises(category, 'tamil');
  }, [category]);

  useEffect(() => {
    // Calculate pagination
    if (praises && Array.isArray(praises)) {
      const startIndex = (currentPage - 1) * PRAISES_PER_PAGE;
      const endIndex = startIndex + PRAISES_PER_PAGE;
      setCurrentPageData(praises.slice(startIndex, endIndex));
    } else {
      setCurrentPageData([]);
    }
  }, [praises, currentPage]);

  const totalPages = Math.ceil((praises?.length || 0) / PRAISES_PER_PAGE);

  const handleNextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  const handlePrevPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  const renderPraise = ({item}: {item: typeof praises[0]}) => (
    <View style={styles.praiseItem}>
      <Text
        style={[
          styles.praiseText,
          {
            fontSize: settings.fontSize,
            color: settings.fontColor,
          },
        ]}>
        {item.id}. {item.praise}
      </Text>
    </View>
  );

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color={theme.colors.primary} />
        <Text style={styles.loadingText}>Loading praises...</Text>
      </View>
    );
  }

  return (
    <View style={[styles.container, {backgroundColor: settings.backgroundColor}]}>
      <StatusBar barStyle="dark-content" backgroundColor={settings.backgroundColor} />

      {/* Praise List */}
      <FlatList
        data={currentPageData}
        renderItem={renderPraise}
        keyExtractor={item => item.id.toString()}
        contentContainerStyle={styles.listContent}
        showsVerticalScrollIndicator={true}
      />

      {/* Bottom Controls */}
      <View style={styles.bottomControls}>
        {/* Page Navigation */}
        <View style={styles.pageControls}>
          <TouchableOpacity
            style={[styles.pageButton, currentPage === 1 && styles.pageButtonDisabled]}
            onPress={handlePrevPage}
            disabled={currentPage === 1}>
            <Text style={styles.pageButtonText}>◀</Text>
          </TouchableOpacity>

          <Text style={styles.pageInfo}>
            Page {currentPage} / {totalPages}
          </Text>

          <TouchableOpacity
            style={[
              styles.pageButton,
              currentPage === totalPages && styles.pageButtonDisabled,
            ]}
            onPress={handleNextPage}
            disabled={currentPage === totalPages}>
            <Text style={styles.pageButtonText}>▶</Text>
          </TouchableOpacity>
        </View>

        {/* Language Toggle */}
        <TouchableOpacity style={styles.languageButton} onPress={toggleLanguage}>
          <Text style={styles.languageButtonText}>
            {currentLanguage === 'tamil' ? 'தமிழ்' : 'Tanglish'}
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: theme.colors.background,
  },
  loadingText: {
    marginTop: theme.spacing.md,
    fontSize: theme.fontSize.md,
    color: theme.colors.textSecondary,
  },
  listContent: {
    padding: theme.spacing.lg,
    paddingBottom: 100,
  },
  praiseItem: {
    marginBottom: theme.spacing.lg,
  },
  praiseText: {
    lineHeight: 28,
  },
  bottomControls: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: theme.colors.background,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border,
    padding: theme.spacing.md,
    elevation: 8,
    shadowColor: '#000',
    shadowOffset: {width: 0, height: -2},
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  pageControls: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.spacing.sm,
  },
  pageButton: {
    backgroundColor: theme.colors.primary,
    paddingHorizontal: theme.spacing.lg,
    paddingVertical: theme.spacing.sm,
    borderRadius: theme.borderRadius.md,
    minWidth: 60,
    alignItems: 'center',
  },
  pageButtonDisabled: {
    backgroundColor: theme.colors.textDisabled,
  },
  pageButtonText: {
    color: '#FFFFFF',
    fontSize: theme.fontSize.lg,
    fontWeight: 'bold',
  },
  pageInfo: {
    fontSize: theme.fontSize.md,
    color: theme.colors.textPrimary,
    fontWeight: '600',
  },
  languageButton: {
    backgroundColor: theme.colors.secondary,
    paddingVertical: theme.spacing.sm,
    borderRadius: theme.borderRadius.md,
    alignItems: 'center',
  },
  languageButtonText: {
    color: '#FFFFFF',
    fontSize: theme.fontSize.md,
    fontWeight: 'bold',
  },
});
