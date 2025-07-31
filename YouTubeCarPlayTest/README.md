# YouTube CarPlay Test App

## 🚗 Om Prosjektet

Dette er en iOS-app som demonstrerer hvordan man kan vise YouTube i CarPlay for testing og utviklingsformål. **VIKTIG**: Dette er kun for testing og utvikling - YouTube i CarPlay er ikke tillatt for produksjonsapper i App Store på grunn av Apples retningslinjer og trafikksikkerhet.

## ⚠️ Viktig Merknad

- **Kun for testing**: Denne appen er kun ment for utvikling og testing
- **Ikke for produksjon**: Apple tillater ikke video-streaming i CarPlay for vanlige apper
- **Trafikksikkerhet**: Aldri se video mens du kjører!

## 🛠 Forutsetninger

- macOS med Xcode 14.0 eller nyere
- iOS-enhet med iOS 14.0 eller nyere
- Apple Developer-konto (for testing på ekte enhet)
- Bil med CarPlay eller CarPlay Simulator

## 📱 Funksjoner

### iOS App
- WebView som viser YouTube mobilnettsted
- Navigasjonsknapper (Hjem, Søk, Oppdater)
- Støtte for inline videoavspilling

### CarPlay
- Grid-basert navigasjon med knapper for:
  - YouTube Hjem
  - Søk
  - Trending
  - Abonnementer
- WebView integrert i CarPlay-vinduet
- Søkefunksjonalitet med CPSearchTemplate

## 🔧 Oppsett

### 1. Åpne Prosjektet i Xcode

```bash
cd YouTubeCarPlayTest
open YouTubeCarPlayTest.xcodeproj
```

### 2. Konfigurer Signing & Capabilities

1. Velg prosjektet i Xcode
2. Gå til "Signing & Capabilities"
3. Velg ditt Development Team
4. Oppdater Bundle Identifier til noe unikt (f.eks. `com.dittfirma.YouTubeCarPlayTest`)

### 3. CarPlay Entitlements

Prosjektet inkluderer allerede CarPlay entitlements, men du må:

1. Gå til Apple Developer Portal
2. Opprett en App ID med CarPlay-støtte
3. Aktiver følgende CarPlay-tillatelser:
   - Audio
   - Communication
   - Navigation
   - Playable Content

### 4. Provisioning Profile

1. Opprett en Development Provisioning Profile som inkluderer CarPlay entitlements
2. Last ned og installer profilen i Xcode

## 🚀 Kjøre Appen

### På iOS Simulator

1. Velg en iPhone simulator
2. Trykk Cmd+R for å bygge og kjøre
3. For CarPlay: I/O → External Displays → CarPlay

### På Ekte Enhet

1. Koble til iPhone via USB
2. Velg enheten i Xcode
3. Trykk Cmd+R for å bygge og kjøre
4. Koble til CarPlay i bilen eller bruk en CarPlay-dongle

## 📂 Prosjektstruktur

```
YouTubeCarPlayTest/
├── YouTubeCarPlayTest/
│   ├── AppDelegate.swift          # Hoved app delegate
│   ├── SceneDelegate.swift        # iOS scene delegate
│   ├── CarPlaySceneDelegate.swift # CarPlay scene delegate
│   ├── ViewController.swift       # Hoved view controller
│   ├── Info.plist                # App konfigurasjon
│   ├── YouTubeCarPlayTest.entitlements # CarPlay tillatelser
│   ├── Base.lproj/
│   │   ├── Main.storyboard       # Hoved UI
│   │   └── LaunchScreen.storyboard
│   └── Assets.xcassets/          # App ikoner og ressurser
└── README.md
```

## 🔍 Hvordan Det Fungerer

### Scene Configuration

Appen bruker iOS 13+ Scene-basert arkitektur med separate scene delegates for iOS og CarPlay:

1. **AppDelegate**: Håndterer scene konfigurasjon
2. **SceneDelegate**: Håndterer vanlig iOS app scene
3. **CarPlaySceneDelegate**: Håndterer CarPlay scene med CPTemplateApplicationSceneDelegate

### CarPlay Implementasjon

1. **CPGridTemplate**: Hovednavigasjon med 4 knapper
2. **CPSearchTemplate**: Søkefunksjonalitet
3. **WKWebView**: Viser YouTube innhold
4. **CPWindow**: CarPlay-vindu som inneholder WebView

## 🐛 Feilsøking

### Vanlige Problemer

1. **"Missing CarPlay entitlement"**
   - Sjekk at Provisioning Profile inkluderer CarPlay
   - Verifiser at entitlements-filen er korrekt

2. **CarPlay vises ikke i simulator**
   - I/O → External Displays → CarPlay
   - Restart simulator om nødvendig

3. **WebView laster ikke**
   - Sjekk internettforbindelse
   - Verifiser NSAppTransportSecurity i Info.plist

### Debug Tips

- Bruk Xcode Console for å se eventuelle feilmeldinger
- Test på ekte CarPlay-enhet for best resultat
- Sjekk at alle Swift-filer er inkludert i target

## 📝 Notater for Videre Utvikling

- Implementer bedre feilhåndtering
- Legg til brukerinnlogging for YouTube
- Forbedre UI/UX i CarPlay
- Implementer playback-kontroller
- Legg til favoritter/spillelister

## ⚖️ Juridisk

Dette prosjektet er kun for utdannings- og testformål. YouTube er et registrert varemerke av Google LLC. Denne appen er ikke tilknyttet eller godkjent av YouTube eller Google.

## 📄 Lisens

Dette prosjektet er laget for testing og læring. Bruk på eget ansvar.