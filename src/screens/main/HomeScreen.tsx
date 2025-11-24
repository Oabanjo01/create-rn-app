import React from "react";
import { Box, Text } from "@/ui";
import { useUser } from "@/store";

export const HomeScreen: React.FC = () => {
  const user = useUser();

  return (
    <Box
      flex={1}
      backgroundColor="background"
      padding="l"
      justifyContent="center"
    >
      <Text variant="header" textAlign="center" marginBottom="m">
        Welcome Home!
      </Text>
      <Text variant="body" textAlign="center" color="textSecondary">
        Hello, {user?.name || "User"}
      </Text>
    </Box>
  );
};
