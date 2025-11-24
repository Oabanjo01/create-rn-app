import React, { useState } from "react";
import { Alert } from "react-native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";

import { Box, Text, Button } from "@/ui";
import { AuthStackParamList } from "@/navigation/auth/AuthNavigator";

type Props = NativeStackScreenProps<AuthStackParamList, "Register">;

export const RegisterScreen: React.FC<Props> = ({ navigation }) => {
  const [loading, setLoading] = useState(false);

  const handleRegister = async () => {
    setLoading(true);

    try {
      // Simulate API call
      await new Promise((resolve) => setTimeout(resolve, 1000));

      Alert.alert("Success", "Account created successfully!", [
        { text: "OK", onPress: () => navigation.navigate("Login") },
      ]);
    } catch (error) {
      Alert.alert("Error", "Registration failed. Please try again.");
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
          Create Account
        </Text>
        <Text variant="body" textAlign="center" color="textSecondary">
          Sign up to get started
        </Text>
      </Box>

      <Box marginBottom="l">
        <Button
          label="Create Account"
          onPress={handleRegister}
          loading={loading}
          disabled={loading}
        />
      </Box>

      <Box flexDirection="row" justifyContent="center">
        <Text variant="caption" color="textSecondary">
          Already have an account?{" "}
        </Text>
        <Text
          variant="caption"
          color="primary"
          onPress={() => navigation.navigate("Login")}
        >
          Sign In
        </Text>
      </Box>
    </Box>
  );
};
