import React, {useState} from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  TextInput,
} from 'react-native';
import {theme} from '../theme';
import {useStore} from '../store/useStore';

export const SettingsScreen = () => {
  const {settings, updateSettings} = useStore();
  const [fontSize, setFontSize] = useState(settings.fontSize.toString());

  const handleFontSizeChange = (value: string) => {
    setFontSize(value);
    const size = parseInt(value, 10);
    if (!isNaN(size) && size >= 12 && size <= 32) {
      updateSettings({fontSize: size});
    }
  };

  const predefinedColors = [
    {name: 'Black', color: '#212121'},
    {name: 'White', color: '#FFFFFF'},
    {name: 'Blue', color: '#2196F3'},
    {name: 'Brown', color: '#795548'},
    {name: 'Green', color: '#4CAF50'},
  ];

  const predefinedBackgrounds = [
    {name: 'White', color: '#FFFFFF'},
    {name: 'Cream', color: '#FFF8DC'},
    {name: 'Light Gray', color: '#F5F5F5'},
    {name: 'Light Blue', color: '#E3F2FD'},
    {name: 'Sepia', color: '#F4ECD8'},
  ];

  return (
    <ScrollView style={styles.container}>
      {/* Font Size */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Font Size</Text>
        <View style={styles.fontSizeContainer}>
          <TouchableOpacity
            style={styles.fontButton}
            onPress={() => handleFontSizeChange((settings.fontSize - 2).toString())}>
            <Text style={styles.fontButtonText}>-</Text>
          </TouchableOpacity>
          <TextInput
            style={styles.fontSizeInput}
            value={fontSize}
            onChangeText={handleFontSizeChange}
            keyboardType="numeric"
          />
          <TouchableOpacity
            style={styles.fontButton}
            onPress={() => handleFontSizeChange((settings.fontSize + 2).toString())}>
            <Text style={styles.fontButtonText}>+</Text>
          </TouchableOpacity>
        </View>
        <Text style={styles.hint}>Size: 12-32 (Current: {settings.fontSize})</Text>
      </View>

      {/* Font Color */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Font Color</Text>
        <View style={styles.colorGrid}>
          {predefinedColors.map(item => (
            <TouchableOpacity
              key={item.color}
              style={[
                styles.colorBox,
                {backgroundColor: item.color},
                settings.fontColor === item.color && styles.colorBoxSelected,
              ]}
              onPress={() => updateSettings({fontColor: item.color})}>
              {item.color === '#FFFFFF' && (
                <View style={styles.colorBoxBorder} />
              )}
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Background Color */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Background Color</Text>
        <View style={styles.colorGrid}>
          {predefinedBackgrounds.map(item => (
            <TouchableOpacity
              key={item.color}
              style={[
                styles.colorBox,
                {backgroundColor: item.color},
                settings.backgroundColor === item.color && styles.colorBoxSelected,
              ]}
              onPress={() => updateSettings({backgroundColor: item.color})}>
              <View style={styles.colorBoxBorder} />
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Preview */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Preview</Text>
        <View
          style={[
            styles.previewBox,
            {backgroundColor: settings.backgroundColor},
          ]}>
          <Text
            style={[
              styles.previewText,
              {
                fontSize: settings.fontSize,
                color: settings.fontColor,
              },
            ]}>
            துதி பலிகள்
          </Text>
          <Text
            style={[
              styles.previewText,
              {
                fontSize: settings.fontSize,
                color: settings.fontColor,
              },
            ]}>
            பரலோகத்தின் தேவனாகிய கர்த்தாவே! உம்மை துதிக்கிறேன்!
          </Text>
        </View>
      </View>

      {/* Reset Button */}
      <TouchableOpacity
        style={styles.resetButton}
        onPress={() =>
          updateSettings({
            fontSize: 18,
            fontColor: '#212121',
            backgroundColor: '#FFFFFF',
          })
        }>
        <Text style={styles.resetButtonText}>Reset to Defaults</Text>
      </TouchableOpacity>

      <View style={{height: 50}} />
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
  section: {
    padding: theme.spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border,
  },
  sectionTitle: {
    fontSize: theme.fontSize.lg,
    fontWeight: '600',
    color: theme.colors.textPrimary,
    marginBottom: theme.spacing.md,
  },
  fontSizeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  fontButton: {
    backgroundColor: theme.colors.primary,
    width: 50,
    height: 50,
    borderRadius: theme.borderRadius.md,
    justifyContent: 'center',
    alignItems: 'center',
  },
  fontButtonText: {
    color: '#FFFFFF',
    fontSize: theme.fontSize.xxl,
    fontWeight: 'bold',
  },
  fontSizeInput: {
    borderWidth: 1,
    borderColor: theme.colors.border,
    borderRadius: theme.borderRadius.md,
    paddingHorizontal: theme.spacing.lg,
    paddingVertical: theme.spacing.sm,
    fontSize: theme.fontSize.xl,
    textAlign: 'center',
    marginHorizontal: theme.spacing.md,
    minWidth: 80,
  },
  hint: {
    fontSize: theme.fontSize.sm,
    color: theme.colors.textSecondary,
    textAlign: 'center',
    marginTop: theme.spacing.sm,
  },
  colorGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: theme.spacing.md,
  },
  colorBox: {
    width: 60,
    height: 60,
    borderRadius: theme.borderRadius.md,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  colorBoxSelected: {
    borderColor: theme.colors.primary,
    borderWidth: 3,
  },
  colorBoxBorder: {
    flex: 1,
    borderWidth: 1,
    borderColor: theme.colors.border,
    borderRadius: theme.borderRadius.md - 2,
  },
  previewBox: {
    padding: theme.spacing.lg,
    borderRadius: theme.borderRadius.md,
    borderWidth: 1,
    borderColor: theme.colors.border,
    minHeight: 150,
    justifyContent: 'center',
  },
  previewText: {
    lineHeight: 28,
    marginBottom: theme.spacing.sm,
  },
  resetButton: {
    margin: theme.spacing.md,
    backgroundColor: theme.colors.error,
    paddingVertical: theme.spacing.md,
    borderRadius: theme.borderRadius.md,
    alignItems: 'center',
  },
  resetButtonText: {
    color: '#FFFFFF',
    fontSize: theme.fontSize.md,
    fontWeight: 'bold',
  },
});
