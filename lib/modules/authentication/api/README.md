# FitNect Authentication API

This directory contains the authentication API implementation for the FitNect app.

## Environment Configuration

The app uses different API endpoints based on the current environment:

- **Development**: `https://fitnect-api.onrender.com/api/v1`
- **Staging**: `https://staging-fitnect-api.onrender.com/api/v1`
- **Production**: `https://api.fitnect.com/api/v1`

These configurations are defined in `lib/core/config/env_config.dart`.

## Google Sign-in API

The Google Sign-in flow works as follows:

1. User initiates Google Sign-in in the app
2. App uses `google_sign_in` package to retrieve user details from Google
3. App sends the Google ID and email to the backend endpoint
4. Backend verifies the information and returns authentication token and user status

### API Endpoint

```
POST /users/google_auth
```

### Request Format

```json
{
  "googleId": "106647825492852842628",
  "email": "example@gmail.com"
}
```

### Response Format

```json
{
  "msg": "",
  "token": "jwt-token-string",
  "onBoarding": true,
  "code": 200
}
```

### Response Fields

- `msg`: Status message from the server
- `token`: JWT authentication token for subsequent API calls
- `onBoarding`: Whether the user has completed onboarding (if true, user is existing; if false, user is new)
- `code`: HTTP status code

### Development Mode

For development purposes, the API includes a fallback mechanism when the backend is not available. 
This behavior can be toggled in `lib/modules/authentication/api/authentication_api.dart`:

```dart
// Development fallback for when there's no backend
if (kDebugMode && true) { // Set to false to use the actual backend
  // Code for development mode...
}
```

## Testing the API

You can test the Google Sign-in API through the Toast Demo page at `/toast-demo`.

## Data Models

The request and response models use Freezed for immutability and code generation:

- `GoogleAuthRequest`: Request model with googleId and email
- `GoogleAuthResponse`: Response model with message, token, onBoarding, and code 