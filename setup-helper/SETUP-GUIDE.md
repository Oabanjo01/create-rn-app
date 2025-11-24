# Setup Guide - Manual Installation

Complete manual setup guide for those who want to understand each step or customize the installation.

## When to Use This Guide

- You want to understand what the automated script does
- You need to customize the setup process
- You're troubleshooting issues
- You prefer manual control over automation

**For quick setup**, use the automated script instead (see [QUICK-START.md](QUICK-START.md)).

---

## Part 1: Prerequisites Installation

### Step 1: Install Node.js

1. Download Node.js v18+ from [nodejs.org](https://nodejs.org/)
2. Run the installer
3. Verify:
```bash
node --version  # Should show v18.0.0 or higher
```

### Step 2: Install Yarn

```bash
npm install -g yarn
yarn --version
```

### Step 3: Install Expo CLI

```bash
npm install -g @expo/cli
expo --version
```

### Step 4: Install EAS CLI

```bash
npm install -g eas-cli
eas --version
```

### Step 5: Create Expo Account & Login

1. Sign up at [expo.dev](https://expo.dev/)
2. Login:
```bash
eas login
eas whoami  # Verify
```

---

## Part 2: Create Project

### Step 1: Create Expo Project

```bash
npx create-expo-app@latest --template blank-typescript YourProjectName --yarn
cd YourProjectName
```

The `--yarn` flag ensures yarn is used instead of npm.

### Step 2: Initialize EAS

```bash
eas whoami  # Check login
eas init    # Initialize EAS
```

---

## Part 3: Install Dependencies

### Core Dependencies

```bash
# Navigation
yarn add @react-navigation/native @react-navigation/native-stack @react-navigation/bottom-tabs

# State Management
yarn add zustand zustand-persist

# API
yarn add axios @tanstack/react-query

# Expo Modules
yarn add expo-router expo-constants expo-dev-client expo-splash-screen expo-status-bar
yarn add expo-secure-store expo-location expo-font expo-system-ui expo-updates
yarn add expo-clipboard expo-document-picker expo-image-picker expo-local-authentication
yarn add expo-task-manager

# UI & Styling
yarn add @shopify/restyle react-native-safe-area-context react-native-screens
yarn add react-native-gesture-handler react-native-reanimated react-native-svg
yarn add @expo/vector-icons

# Forms
yarn add formik yup

# Utilities
yarn add date-fns lodash moment react-native-mmkv react-native-get-random-values
yarn add @react-native-community/netinfo

# Dev Dependencies
yarn add -D @babel/core @types/react @types/lodash
yarn add -D babel-plugin-module-resolver patch-package react-native-svg-transformer typescript
```

---

## Part 4: Create Directory Structure

```bash
# Create directories
mkdir -p src/{api,components,constants,hooks,navigation,screens,store,theme,types,ui,utils}
mkdir -p src/api/services
mkdir -p src/components/{forms,loading,modal,providers}
mkdir -p src/navigation/{auth,main}
mkdir -p src/screens/{auth,main}
mkdir -p src/types/{api,navigation}
mkdir -p assets/{images,fonts,icons}

# Create index files
touch src/components/index.ts
touch src/hooks/index.ts
touch src/store/index.ts
touch src/utils/index.ts
touch src/ui/index.ts
```

---

## Part 5: Configure Babel

Create `babel.config.js`:

```javascript
module.exports = function (api) {
  api.cache(true);
  return {
    presets: ["babel-preset-expo"],
    plugins: [
      [
        "module-resolver",
        {
          root: ["./"],
          alias: {
            "@": "./src",
            "@components": "./src/components",
            "@ui": "./src/ui",
            "@screens": "./src/screens",
            "@navigation": "./src/navigation",
            "@theme": "./src/theme",
            "@store": "./src/store",
            "@hooks": "./src/hooks",
            "@utils": "./src/utils",
            "@assets": "./assets",
          },
        },
      ],
      "react-native-reanimated/plugin",
    ],
  };
};
```

---

## Part 6: Configure Metro

Create `metro.config.js`:

```javascript
const { getDefaultConfig } = require("expo/metro-config");

module.exports = (() => {
  const config = getDefaultConfig(__dirname);
  const { transformer, resolver } = config;

  config.transformer = {
    ...transformer,
    babelTransformerPath: require.resolve("react-native-svg-transformer"),
  };
  
  config.resolver = {
    ...resolver,
    assetExts: resolver.assetExts.filter((ext) => ext !== "svg"),
    sourceExts: [...resolver.sourceExts, "svg"],
  };

  return config;
})();
```

---

## Part 7: Configure TypeScript

Create `tsconfig.json`:

```json
{
  "extends": "expo/tsconfig.base",
  "compilerOptions": {
    "strict": true,
    "baseUrl": ".",
    "skipLibCheck": true,
    "types": [],
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@ui": ["src/ui"],
      "@screens/*": ["src/screens/*"],
      "@navigation/*": ["src/navigation/*"],
      "@theme/*": ["src/theme/*"],
      "@store/*": ["src/store/*"],
      "@hooks/*": ["src/hooks/*"],
      "@utils/*": ["src/utils/*"],
      "@assets/*": ["assets/*"]
    }
  },
  "exclude": ["node_modules"],
  "include": ["**/*.ts", "**/*.tsx", "src/types/*.d.ts"]
}
```

---

## Part 8: Environment Files

Create `.env.example`:

```
EXPO_PUBLIC_API_BASE_URL=https://your-api.com
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY_ANDROID=your_key
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY_IOS=your_key
```

Copy to `.env`:

```bash
cp .env.example .env
```

---

## Part 9: Update .gitignore

Add to `.gitignore`:

```
# Environment
.env
.env*.local
.env.production

# EAS
.eas/

# Builds
*.apk
*.app
*.tar.gz

# Patches
patches/
```

---

## Part 10: Add Build Scripts

Add to `package.json` scripts section:

```json
{
  "scripts": {
    "prebuild:android": "expo prebuild --platform android",
    "prebuild:ios": "expo prebuild --platform ios",
    "prebuild:all": "expo prebuild",
    "build:dev:android": "eas build --platform android --profile development",
    "build:dev:ios": "eas build --platform ios --profile development",
    "build:preview:android": "eas build --platform android --profile preview",
    "build:preview:ios": "eas build --platform ios --profile preview",
    "build:prod:android": "eas build --platform android --profile production",
    "build:prod:ios": "eas build --platform ios --profile production",
    "postinstall": "patch-package"
  }
}
```

---

## Part 11: Copy Starter Files

From the `starter-files` directory, copy:

```bash
# Copy source files
cp -r ../starter-files/src/* ./src/

# Copy App.tsx
cp ../starter-files/App.tsx ./App.tsx
```

Or use the helper script:

```bash
cd ../starter-files
./copy-starter-files.sh ../YourProjectName
```

---

## Part 12: Configure Your App

### Update `app.config.js`:

```javascript
export default {
  expo: {
    name: "Your App Name",
    slug: "your-app-slug",
    version: "1.0.0",
    runtimeVersion: "1.0.0",
    orientation: "portrait",
    icon: "./assets/images/icon.png",
    userInterfaceStyle: "automatic",
    newArchEnabled: true,
    
    splash: {
      image: "./assets/images/splash.png",
      resizeMode: "contain",
      backgroundColor: "#FFFFFF",
    },
    
    ios: {
      bundleIdentifier: "com.yourcompany.yourapp",
      supportsTablet: true,
    },
    
    android: {
      package: "com.yourcompany.yourapp",
      adaptiveIcon: {
        foregroundImage: "./assets/images/adaptive-icon.png",
        backgroundColor: "#ffffff",
      },
    },
  },
};
```

### Update `.env`:

```
EXPO_PUBLIC_API_BASE_URL=https://your-api.com
```

### Customize Theme (`src/theme/colors.ts`):

```typescript
export const palette = {
  primary: '#YOUR_BRAND_COLOR',
  secondary: '#YOUR_SECONDARY_COLOR',
  // ... more colors
};
```

---

## Part 13: Start Development

```bash
yarn start
```

---

## Troubleshooting

### Module Resolution Errors

```bash
rm -rf node_modules
yarn cache clean
yarn install
yarn start --clear
```

### TypeScript Path Errors

1. Restart TypeScript server in your IDE
2. Or restart dev server: `yarn start --clear`

### Metro Bundler Issues

```bash
yarn start --clear
```

### EAS Init Failed

```bash
eas whoami  # Check login
eas login   # Login if needed
eas init    # Try again
```

### Yarn Not Found

```bash
npm install -g yarn
yarn --version
```

### Permission Denied on Scripts

```bash
chmod +x *.sh
```

---

## Project Structure

```
YourProjectName/
├── src/
│   ├── api/
│   │   ├── services/
│   │   ├── client.ts
│   │   └── queryClient.ts
│   ├── components/
│   ├── navigation/
│   │   ├── auth/AuthNavigator.tsx
│   │   ├── main/MainNavigator.tsx
│   │   └── RootNavigator.tsx
│   ├── screens/
│   │   ├── auth/
│   │   └── main/
│   ├── store/
│   │   ├── auth.ts
│   │   ├── theme.ts
│   │   └── index.ts
│   ├── theme/
│   │   ├── colors.ts
│   │   └── index.ts
│   ├── ui/
│   │   ├── Box.tsx
│   │   ├── Text.tsx
│   │   ├── Button.tsx
│   │   └── index.ts
│   └── utils/
│       └── mmkvStorage.ts
├── assets/
├── App.tsx
├── app.config.js
├── babel.config.js
├── metro.config.js
├── tsconfig.json
├── package.json
└── .env
```

---

## Next Steps

1. Test the app: `yarn start`
2. Run on device: `yarn android` or `yarn ios`
3. Customize theme colors
4. Add your API endpoints
5. Build your features!

---

**Quick start?** See [QUICK-START.md](QUICK-START.md)

**Issues?** Check the troubleshooting section above