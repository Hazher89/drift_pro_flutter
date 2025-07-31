# CarPlay YouTube Test App

Denne appen er konfigurert for testing av CarPlay-funksjonalitet med YouTube-videoer.

## Funksjoner

- ✅ CarPlay-støtte konfigurert
- ✅ YouTube-video avspilling via WebView
- ✅ Test-videoer inkludert
- ✅ iOS-entitlements for CarPlay
- ✅ Background audio support

## Test-videoer inkludert

1. **Rick Roll** (dQw4w9WgXcQ) - Klassisk test-video
2. **Me at the zoo** (jNQXAC9IVRw) - Første YouTube-video noensinne
3. **Despacito** (kJQP7kiw5Fk) - Populær test-video

## Installasjon og testing

### 1. Installer dependencies
```bash
flutter pub get
```

### 2. iOS-spesifikke steg
```bash
cd ios
pod install
cd ..
```

### 3. Bygg og kjør appen
```bash
flutter run
```

## CarPlay Testing

### Simulator Testing
1. Åpne Xcode
2. Gå til `Window > CarPlay Simulator`
3. Start CarPlay-simulatoren
4. Kjør appen på iOS-simulatoren
5. Koble til CarPlay-simulatoren

### Fysisk Testing
1. Koble iPhone til bilen med CarPlay
2. Åpne appen på telefonen
3. Appen skal vises i CarPlay-menyen
4. Velg "YouTube Test" for å teste video-funksjonalitet

## Viktige filer

- `ios/Runner/AppDelegate.swift` - CarPlay-konfigurasjon
- `ios/Runner/Info.plist` - App-tillatelser
- `ios/Runner/Runner.entitlements` - CarPlay-entitlements
- `lib/youtube_player.dart` - YouTube-spiller widget
- `lib/main.dart` - Hovedapp med CarPlay-test knapp

## CarPlay Entitlements

Appen har følgende CarPlay-entitlements aktivert:
- `carplay-audio` - Audio-avspilling
- `carplay-entertainment` - Underholdning
- `carplay-information` - Informasjon
- `carplay-maps` - Kart
- `carplay-messaging` - Meldinger
- `carplay-voip-calling` - VoIP-samtaler
- `carplay-charging` - Lading
- `carplay-parking` - Parkering

## Sikkerhet

⚠️ **VIKTIG**: Dette er kun for testing. Appen har `NSAllowsArbitraryLoads` aktivert for å tillate YouTube-embedding. I produksjon bør du bruke mer restriktive innstillinger.

## Feilsøking

### CarPlay vises ikke
1. Sjekk at CarPlay-entitlements er riktig konfigurert
2. Verifiser at appen er signert med riktig provisioning profile
3. Sjekk at CarPlay-simulatoren er startet

### YouTube-videoer spiller ikke
1. Sjekk internett-tilkobling
2. Verifiser at WebView har JavaScript aktivert
3. Sjekk at video-IDene er korrekte

## Utvikling

For å legge til flere test-videoer, rediger `lib/youtube_player.dart` og legg til nye videoer i `testVideos`-listen.

```dart
final testVideos = [
  {
    'id': 'VIDEO_ID_HER',
    'title': 'Video Tittel',
    'description': 'Video beskrivelse',
  },
  // Legg til flere videoer her...
];
```