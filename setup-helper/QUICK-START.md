# Quick Start

Get started in 5 minutes.

## 🚀 Create Project

```bash
./verify-setup.sh                    # Check prerequisites
./setup-new-project.sh MyApp         # Create project  
cd MyApp && yarn start               # Start development
```

## ✅ Prerequisites

| Tool | Install |
|------|---------|
| Node.js v18+ | [nodejs.org](https://nodejs.org/) |
| Yarn | `npm install -g yarn` |
| Expo CLI | `npm install -g @expo/cli` |
| EAS CLI | `npm install -g eas-cli` |

Then login: `eas login`

## 🎯 What You Get

**Tech Stack:**
- React Native + Expo SDK 54+
- TypeScript
- React Navigation 7
- Zustand + MMKV storage
- Shopify Restyle theming
- Axios + React Query
- Formik + Yup

**Included:**
- Auth flow (Login/Register)
- Main navigation (Home/Profile tabs)
- Dark/light theme
- API client with interceptors
- Path aliases (`@/`, `@components/`, etc.)

## 📱 Commands

```bash
yarn start              # Start dev server
yarn android           # Run on Android
yarn ios              # Run on iOS

yarn build:dev:android    # Development build
yarn build:preview:android # Preview build
yarn build:prod:android   # Production build
```

## ⚙️ Quick Config

**1. App Identity** (`app.config.js`):
```javascript
name: "Your App Name",
slug: "your-app-slug",
ios: { bundleIdentifier: "com.yourcompany.app" },
android: { package: "com.yourcompany.app" },
```

**2. API Endpoint** (`.env`):
```
EXPO_PUBLIC_API_BASE_URL=https://your-api.com
```

**3. Brand Colors** (`src/theme/colors.ts`):
```typescript
primary: '#007AFF',      // Your brand color
secondary: '#FF9500',    // Secondary color
```

## 💡 Usage Examples

**Theme System:**
```typescript
import { Box, Text, Button } from '@/ui';

<Box padding="l" margin="m">
  <Text variant="header" color="primary">Hello</Text>
  <Button label="Click Me" variant="primary" />
</Box>
```

**Authentication:**
```typescript
import { useAuthStore } from '@/store';

const login = useAuthStore((state) => state.login);
login(user, token);  // Auto-navigates to main app

const logout = useAuthStore((state) => state.logout);
logout();  // Auto-navigates to login
```

**API Calls:**
```typescript
import { apiClient } from '@/api/client';
import { useQuery } from '@tanstack/react-query';

const { data } = useQuery({
  queryKey: ['users'],
  queryFn: () => apiClient.get('/users'),
});
```

**Navigation:**
```typescript
import { useNavigation } from '@react-navigation/native';

const navigation = useNavigation();
navigation.navigate('Profile');
navigation.goBack();
```

## 🐛 Common Issues

| Issue | Fix |
|-------|-----|
| "Project name required" | `./setup-new-project.sh MyApp` |
| "yarn not found" | `npm install -g yarn` |
| "Not logged in" | `eas login` |
| Module errors | `rm -rf node_modules && yarn install` |

## 📚 Next Steps

1. Customize theme colors
2. Update `.env` with your API
3. Add screens in `src/screens/`
4. Create components in `src/components/`
5. Build your app!

---

**Need detailed setup?** See [SETUP-GUIDE.md](SETUP-GUIDE.md)