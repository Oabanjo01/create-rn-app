#!/bin/bash

# Script to copy starter files to a newly created project
# Usage: ./copy-starter-files.sh <project-directory>

set -e

if [ -z "$1" ]; then
  echo "❌ Error: Project directory is required"
  echo "Usage: ./copy-starter-files.sh <project-directory>"
  echo "Example: ./copy-starter-files.sh ../MyAwesomeApp"
  exit 1
fi

PROJECT_DIR=$1

# Check if project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "❌ Error: Project directory '$PROJECT_DIR' does not exist"
  exit 1
fi

echo "📦 Copying starter files to $PROJECT_DIR..."

# Copy source files
echo "📁 Copying src directory..."
if [ -d "$PROJECT_DIR/src" ]; then
  echo "⚠️  src directory already exists, merging files..."
fi
cp -r ./src/* "$PROJECT_DIR/src/" 2>/dev/null || mkdir -p "$PROJECT_DIR/src" && cp -r ./src/* "$PROJECT_DIR/src/"

# Copy App.tsx
echo "📄 Copying App.tsx..."
if [ -f "$PROJECT_DIR/App.tsx" ]; then
  echo "⚠️  App.tsx already exists, creating backup..."
  mv "$PROJECT_DIR/App.tsx" "$PROJECT_DIR/App.tsx.backup"
fi
cp ./App.tsx "$PROJECT_DIR/App.tsx"

# Copy configuration files if they don't exist
if [ ! -f "$PROJECT_DIR/babel.config.js" ]; then
  echo "📄 Copying babel.config.js..."
  cat > "$PROJECT_DIR/babel.config.js" << 'EOF'
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
fi

if [ ! -f "$PROJECT_DIR/metro.config.js" ]; then
  echo "📄 Copying metro.config.js..."
  cat > "$PROJECT_DIR/metro.config.js" << 'EOF'
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
fi

echo ""
echo "✅ Starter files copied successfully!"
echo ""
echo "📋 Next steps:"
echo "1. cd $PROJECT_DIR"
echo "2. Update app.config.js with your app details"
echo "3. Configure .env with your API endpoints"
echo "4. Customize src/theme/colors.ts for your brand"
echo "5. yarn start"
echo ""
echo "🎉 Happy coding!"