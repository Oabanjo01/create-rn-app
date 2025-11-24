#!/bin/bash

# Script to verify all prerequisites are installed correctly
# Run this before using setup-new-project.sh

echo "🔍 Verifying React Native Expo Setup Prerequisites..."
echo ""

ERRORS=0

# Check Node.js
echo -n "Checking Node.js... "
if command -v node &> /dev/null; then
  NODE_VERSION=$(node --version)
  echo "✅ $NODE_VERSION"
else
  echo "❌ Not installed"
  echo "   Install from: https://nodejs.org/"
  ERRORS=$((ERRORS + 1))
fi

# Check Yarn
echo -n "Checking Yarn... "
if command -v yarn &> /dev/null; then
  YARN_VERSION=$(yarn --version)
  echo "✅ v$YARN_VERSION"
else
  echo "❌ Not installed"
  echo "   Install with: npm install -g yarn"
  ERRORS=$((ERRORS + 1))
fi

# Check Expo CLI
echo -n "Checking Expo CLI... "
if command -v expo &> /dev/null; then
  EXPO_VERSION=$(expo --version)
  echo "✅ v$EXPO_VERSION"
else
  echo "❌ Not installed"
  echo "   Install with: npm install -g @expo/cli"
  ERRORS=$((ERRORS + 1))
fi

# Check EAS CLI
echo -n "Checking EAS CLI... "
if command -v eas &> /dev/null; then
  EAS_VERSION=$(eas --version)
  echo "✅ $EAS_VERSION"
else
  echo "❌ Not installed"
  echo "   Install with: npm install -g eas-cli"
  ERRORS=$((ERRORS + 1))
fi

# Check EAS Login
echo -n "Checking EAS Login... "
if eas whoami &> /dev/null; then
  EAS_USER=$(eas whoami 2>&1)
  echo "✅ Logged in as: $EAS_USER"
else
  echo "❌ Not logged in"
  echo "   Login with: eas login"
  ERRORS=$((ERRORS + 1))
fi

# Check Git
echo -n "Checking Git... "
if command -v git &> /dev/null; then
  GIT_VERSION=$(git --version | cut -d' ' -f3)
  echo "✅ v$GIT_VERSION"
else
  echo "⚠️  Not installed (optional but recommended)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -eq 0 ]; then
  echo "✅ All prerequisites are installed!"
  echo ""
  echo "You're ready to create a new project:"
  echo "  ./setup-new-project.sh YourProjectName"
else
  echo "❌ Found $ERRORS issue(s)"
  echo ""
  echo "Please install the missing tools and try again."
  echo ""
  echo "Quick install commands:"
  echo "  npm install -g yarn"
  echo "  npm install -g @expo/cli"
  echo "  npm install -g eas-cli"
  echo "  eas login"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

exit $ERRORS