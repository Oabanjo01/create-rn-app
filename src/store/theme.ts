import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import { mmkvStorage } from "@/utils/mmkvStorage";

export type ThemeMode = "light" | "dark" | "system";

interface ThemeState {
  mode: ThemeMode;
  isDark: boolean;
}

interface ThemeActions {
  setThemeMode: (mode: ThemeMode) => void;
  setIsDark: (isDark: boolean) => void;
}

export type ThemeStore = ThemeState & ThemeActions;

export const useThemeStore = create<ThemeStore>()(
  persist(
    (set) => ({
      mode: "system",
      isDark: false,
      setThemeMode: (mode) => set({ mode }),
      setIsDark: (isDark) => set({ isDark }),
    }),
    {
      name: "theme-storage",
      storage: createJSONStorage(() => mmkvStorage),
    }
  )
);

// Selector hooks
export const useThemeMode = () => useThemeStore((state) => state.mode);
export const useIsDark = () => useThemeStore((state) => state.isDark);
