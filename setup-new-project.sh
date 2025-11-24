#!/bin/bash

# React Native Expo Project Setup Script
# Based on Exon Driver app architecture

set -e

# Check if project name is provided
if [ -z "$1" ]; then
  echo "❌ Error: Project name is required"
  echo "Usage: ./setup-new-project.sh <project-name>"
  echo "Example: ./setup-new-project.sh MyAwesomeApp"
  exit 1
fi

PROJECT_NAME=$1
echo "🚀 Setting up new React Native Expo project: $PROJECT_NAME"

# Check if yarn is installed
if ! command -v yarn &> /dev/null; then
  echo "❌ Error: yarn is not installed"
  echo "Please install yarn first: npm install -g yarn"
  exit 1
fi

# Create new Expo project
echo "📱 Creating Expo project..."
npx create-expo-app@latest --template blank-typescript "$PROJECT_NAME" --yarn
cd "$PROJECT_NAME"

# Check if user is logged into EAS
echo "🔧 Checking EAS login status..."
if ! eas whoami &> /dev/null; then
  echo "⚠️  You are not logged into EAS CLI"
  echo "Please login to EAS to continue:"
  eas login
fi

# Initialize EAS
echo "🔧 Initializing EAS..."
eas init

# Install core dependencies
echo "📦 Installing core dependencies..."
yarn add @react-navigation/native @react-navigation/native-stack @react-navigation/bottom-tabs
yarn add zustand zustand-persist
yarn add axios @tanstack/react-query

# Install Expo modules
echo "📦 Installing Expo modules..."
yarn add expo-router expo-constants expo-dev-client expo-splash-screen expo-status-bar
yarn add expo-secure-store expo-location expo-font expo-system-ui expo-updates
yarn add expo-clipboard expo-document-picker expo-image-picker expo-local-authentication
yarn add expo-task-manager

# Install UI and styling
echo "🎨 Installing UI dependencies..."
yarn add @shopify/restyle react-native-safe-area-context react-native-screens
yarn add react-native-gesture-handler react-native-reanimated react-native-svg
yarn add @expo/vector-icons

# Install forms and validation
echo "📝 Installing form dependencies..."
yarn add formik yup

# Install utilities
echo "🛠️ Installing utilities..."
yarn add date-fns lodash moment react-native-mmkv
yarn add react-native-get-random-values
yarn add @react-native-community/netinfo

# Install development dependencies
echo "🔧 Installing dev dependencies..."
yarn add -D @babel/core @types/react @types/lodash
yarn add -D babel-plugin-module-resolver patch-package
yarn add -D react-native-svg-transformer typescript

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p src/{api,components,constants,hooks,navigation,screens,store,theme,types,ui,utils}
mkdir -p src/api/services
mkdir -p src/components/{forms,loading,modal,providers}
mkdir -p src/navigation/{auth,main,modal}
mkdir -p src/screens/{auth,main,shared}
mkdir -p src/types/{api,navigation}
mkdir -p assets/{images,fonts,icons}

# Create index files
touch src/components/index.ts
touch src/hooks/index.ts
touch src/store/index.ts
touch src/utils/index.ts
touch src/ui/index.ts

# Copy starter files (you would need to copy the files we created above)
echo "📄 Setting up starter files..."
echo "// Export your components here" > src/components/index.ts
echo "// Export your hooks here" > src/hooks/index.ts
echo "// Export your stores here" > src/store/index.ts
echo "// Export your utilities here" > src/utils/index.ts

# Create environment file
echo "🔐 Creating environment files..."
cat > .env.example << EOF
EXPO_PUBLIC_API_BASE_URL=https://your-api.com
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY_ANDROID=your_android_key
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY_IOS=your_ios_key
EOF

cp .env.example .env

# Update .gitignore
echo "📝 Updating .gitignore..."
cat >> .gitignore << EOF

# Environment files
.env
.env*.local
.env.production

# EAS
.eas/

# Kiro (if using)
.kiro/

# Build artifacts
*.apk
*.app
*.tar.gz

# Patches
patches/
EOF

# Update package.json scripts using node
echo "📝 Updating package.json scripts..."
node -e "
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
pkg.scripts = {
  ...pkg.scripts,
  'prebuild:android': 'expo prebuild --platform android',
  'prebuild:ios': 'expo prebuild --platform ios',
  'prebuild:all': 'expo prebuild',
  'build:dev:android': 'eas build --platform android --profile development',
  'build:dev:ios': 'eas build --platform ios --profile development',
  'build:preview:android': 'eas build --platform android --profile preview',
  'build:preview:ios': 'eas build --platform ios --profile preview',
  'build:prod:android': 'eas build --platform android --profile production',
  'build:prod:ios': 'eas build --platform ios --profile production',
  'postinstall': 'patch-package'
};
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
"

# Copy starter files
echo ""
echo "📦 Copying starter files..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy source files
if [ -d "$SCRIPT_DIR/src" ]; then
  echo "📁 Copying src directory..."
  cp -r "$SCRIPT_DIR/src"/* ./src/ 2>/dev/null || true
fi

# Copy App.tsx
if [ -f "$SCRIPT_DIR/App.tsx" ]; then
  echo "📄 Copying App.tsx..."
  cp "$SCRIPT_DIR/App.tsx" ./App.tsx
fi

# Update babel.config.js
echo "📄 Updating babel.config.js..."
cat > babel.config.js << 'EOF'
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
EOF

# Update metro.config.js
echo "📄 Updating metro.config.js..."
cat > metro.config.js << 'EOF'
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
EOF

# Update tsconfig.json
echo "📄 Updating tsconfig.json..."
cat > tsconfig.json << 'EOF'
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
EOF

echo ""
echo "✅ Project setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. cd $PROJECT_NAME"
echo "2. Update app.config.js with your app details (name, slug, bundle ID)"
echo "3. Configure .env with your API endpoints"
echo "4. Customize src/theme/colors.ts for your brand colors"
echo "5. yarn start"
echo ""
echo "📚 Useful commands:"
echo "  yarn start              - Start development server"
echo "  yarn android           - Run on Android"
echo "  yarn ios              - Run on iOS"
echo "  yarn build:dev:android - Build development APK"
echo ""
echo "🎉 Happy coding!"