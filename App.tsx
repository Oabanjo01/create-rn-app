import React from "react";
import { StatusBar } from "expo-status-bar";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { QueryClientProvider } from "@tanstack/react-query";
import { ThemeProvider } from "@shopify/restyle";
import { GestureHandlerRootView } from "react-native-gesture-handler";

import { theme, darkTheme } from "@/theme";
import { queryClient } from "@/api/queryClient";
import { useIsDark } from "@/store";
import { RootNavigator } from "@/navigation/RootNavigator";

export default function App() {
  const isDark = useIsDark();

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <SafeAreaProvider>
        <QueryClientProvider client={queryClient}>
          <ThemeProvider theme={isDark ? darkTheme : theme}>
            <StatusBar style={isDark ? "light" : "dark"} />
            <RootNavigator />
          </ThemeProvider>
        </QueryClientProvider>
      </SafeAreaProvider>
    </GestureHandlerRootView>
  );
}
