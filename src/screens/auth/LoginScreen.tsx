import React, { useState } from "react";
import { Alert } from "react-native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";

import { Box, Text, Button } from "@/ui";
import { useAuthStore } from "@/store";
import { AuthStackParamList } from "@/navigation/auth/AuthNavigator";

type Props = NativeStackScreenProps<AuthStackParamList, "Login">;

export const LoginScreen: React.FC<Props> = ({ navigation }) => {
  const [loading, setLoading] = useState(false);
  const login = useAuthStore((state) => state.login);

  const handleLogin = async () => {
    setLoading(true);

    try {
      // Simulate API call
      await new Promise((resolve) => setTimeout(resolve, 1000));

      // Mock successful login
      const mockUser = {
        id: "1",
        email: "user@example.com",
        name: "John Doe",
      };
      const mockToken = "mock-jwt-token";

      login(mockUser, mockToken);
    } catch (error) {
      Alert.alert("Error", "Login failed. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box
      flex={1}
      backgroundColor="background"
      padding="l"
      justifyContent="center"
    >
      <Box marginBottom="xl">
        <Text variant="header" textAlign="center" marginBottom="m">
          Welcome Back
        </Text>
        <Text variant="body" textAlign="center" color="textSecondary">
          Sign in to your account
        </Text>
      </Box>

      <Box marginBottom="l">
        <Button
          label="Sign In"
          onPress={handleLogin}
          loading={loading}
          disabled={loading}
        />
      </Box>

      <Box flexDirection="row" justifyContent="center">
        <Text variant="caption" color="textSecondary">
          Don't have an account?{" "}
        </Text>
        <Text
          variant="caption"
          color="primary"
          onPress={() => navigation.navigate("Register")}
        >
          Sign Up
        </Text>
      </Box>
    </Box>
  );
};
