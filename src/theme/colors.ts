export const palette = {
  // Primary colors
  primary: "#007AFF",
  primaryDark: "#0056CC",
  primaryLight: "#4DA3FF",

  // Secondary colors
  secondary: "#FF9500",
  secondaryDark: "#CC7700",
  secondaryLight: "#FFB84D",

  // Neutral colors
  white: "#FFFFFF",
  black: "#000000",

  // Gray scale
  gray50: "#F9FAFB",
  gray100: "#F3F4F6",
  gray200: "#E5E7EB",
  gray300: "#D1D5DB",
  gray400: "#9CA3AF",
  gray500: "#6B7280",
  gray600: "#4B5563",
  gray700: "#374151",
  gray800: "#1F2937",
  gray900: "#111827",

  // Status colors
  success: "#10B981",
  warning: "#F59E0B",
  error: "#EF4444",
  info: "#3B82F6",

  // Background colors
  background: "#FFFFFF",
  backgroundSecondary: "#F9FAFB",
  surface: "#FFFFFF",

  // Text colors
  text: "#111827",
  textSecondary: "#6B7280",
  textMuted: "#9CA3AF",

  // Border colors
  border: "#E5E7EB",
  borderLight: "#F3F4F6",
};

export const darkPalette = {
  ...palette,

  // Override for dark mode
  background: "#111827",
  backgroundSecondary: "#1F2937",
  surface: "#374151",

  text: "#F9FAFB",
  textSecondary: "#D1D5DB",
  textMuted: "#9CA3AF",

  border: "#374151",
  borderLight: "#4B5563",
};
