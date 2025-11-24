import React from "react";
import { Box, Text, Button } from "@/ui";
import { useUser, useAuthStore } from "@/store";

export const ProfileScreen: React.FC = () => {
  const user = useUser();
  const logout = useAuthStore((state) => state.logout);

  return (
    <Box
      flex={1}
      backgroundColor="background"
      padding="l"
      justifyContent="center"
    >
      <Box marginBottom="xl">
        <Text variant="header" textAlign="center" marginBottom="m">
          Profile
        </Text>
        <Text variant="body" textAlign="center" color="textSecondary">
          {user?.email}
        </Text>
      </Box>

      <Button label="Sign Out" onPress={logout} variant="outline" />
    </Box>
  );
};
