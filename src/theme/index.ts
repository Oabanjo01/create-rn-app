import { createTheme } from "@shopify/restyle";
import { palette, darkPalette } from "./colors";

const spacing = {
  xs: 4,
  s: 8,
  m: 16,
  l: 24,
  xl: 32,
  xxl: 48,
};

const borderRadii = {
  s: 4,
  m: 8,
  l: 12,
  xl: 16,
  xxl: 24,
  round: 999,
};

const textVariants = {
  header: {
    fontSize: 28,
    fontWeight: "bold" as const,
    lineHeight: 34,
    color: "text",
  },
  title: {
    fontSize: 24,
    fontWeight: "600" as const,
    lineHeight: 30,
    color: "text",
  },
  subtitle: {
    fontSize: 20,
    fontWeight: "600" as const,
    lineHeight: 26,
    color: "text",
  },
  body: {
    fontSize: 16,
    fontWeight: "400" as const,
    lineHeight: 22,
    color: "text",
  },
  bodyMedium: {
    fontSize: 16,
    fontWeight: "500" as const,
    lineHeight: 22,
    color: "text",
  },
  caption: {
    fontSize: 14,
    fontWeight: "400" as const,
    lineHeight: 18,
    color: "textSecondary",
  },
  captionMedium: {
    fontSize: 14,
    fontWeight: "500" as const,
    lineHeight: 18,
    color: "text",
  },
  small: {
    fontSize: 12,
    fontWeight: "400" as const,
    lineHeight: 16,
    color: "textMuted",
  },
  button: {
    fontSize: 16,
    fontWeight: "600" as const,
    lineHeight: 20,
    color: "white",
  },
};

export const theme = createTheme({
  colors: palette,
  spacing,
  borderRadii,
  textVariants,
  breakpoints: {
    phone: 0,
    tablet: 768,
  },
});

export const darkTheme = createTheme({
  ...theme,
  colors: darkPalette,
});

export type Theme = typeof theme;
export type ThemeColors = keyof Theme["colors"];
export type ThemeSpacing = keyof Theme["spacing"];
export type ThemeBorderRadii = keyof Theme["borderRadii"];
export type ThemeTextVariants = keyof Theme["textVariants"];
