import {
  createRestyleComponent,
  createVariant,
  VariantProps,
} from "@shopify/restyle";
import { Pressable as RNPressable } from "react-native";
import { Theme } from "@/theme";

export const Pressable = createRestyleComponent<
  VariantProps<Theme, "cardVariants"> &
    React.ComponentProps<typeof RNPressable>,
  Theme
>([createVariant({ themeKey: "cardVariants" })], RNPressable);
