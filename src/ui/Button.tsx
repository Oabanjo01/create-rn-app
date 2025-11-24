import React from "react";
import {
  ActivityIndicator,
  TouchableOpacity,
  TouchableOpacityProps,
} from "react-native";
import {
  createRestyleComponent,
  createVariant,
  VariantProps,
} from "@shopify/restyle";
import { Theme } from "@/theme";
import { Text } from "./Text";

const ButtonContainer = createRestyleComponent<
  VariantProps<Theme, "buttonVariants"> &
    React.ComponentProps<typeof TouchableOpacity>,
  Theme
>([createVariant({ themeKey: "buttonVariants" })], TouchableOpacity);

interface ButtonProps extends TouchableOpacityProps {
  label: string;
  variant?: "primary" | "secondary" | "outline" | "ghost";
  size?: "small" | "medium" | "large";
  loading?: boolean;
  disabled?: boolean;
}

export const Button: React.FC<ButtonProps> = ({
  label,
  variant = "primary",
  size = "medium",
  loading = false,
  disabled = false,
  ...props
}) => {
  const isDisabled = disabled || loading;

  return (
    <ButtonContainer
      variant={variant}
      disabled={isDisabled}
      opacity={isDisabled ? 0.6 : 1}
      {...props}
    >
      {loading ? (
        <ActivityIndicator color="white" />
      ) : (
        <Text variant="button" textAlign="center">
          {label}
        </Text>
      )}
    </ButtonContainer>
  );
};
