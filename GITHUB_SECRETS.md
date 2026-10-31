# GitHub Actions Secrets Required for RegistAgro Consumer CI/CD

## Repository Settings → Secrets and Variables → Actions → New Repository Secret

### Required Secrets

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `API_BASE_URL` | Base URL da API backend (produção) | `https://api-registagro.onrender.com` |
| `TURNSTILE_SITE_KEY` | Cloudflare Turnstile site key (para CAPTCHA) | `0x4AAAAA...` |

### Optional Secrets (para notificações)

| Secret Name | Description |
|-------------|-------------|
| `SLACK_WEBHOOK_URL` | Webhook Slack para notificações de build |
| `DISCORD_WEBHOOK_URL` | Webhook Discord para notificações |
| `TEAM_ID` | Apple Developer Team ID (para build iOS) |
| `APP_STORE_CONNECT_API_KEY_ID` | App Store Connect API Key ID |
| `APP_STORE_CONNECT_API_ISSUER_ID` | App Store Connect Issuer ID |
| `APP_STORE_CONNECT_API_KEY` | App Store Connect Private Key (base64) |

---

## Como configurar no GitHub:

1. Acesse: `https://github.com/RegistAgro-project-community/RegistAgro-repository/settings/secrets/actions`
2. Clique em "New repository secret"
3. Adicione cada segredo da tabela acima

---

## Build local com variáveis:

```bash
# Debug
flutter run --dart-define=API_BASE_URL=https://api-registagro.onrender.com \
  --dart-define=TURNSTILE_SITE_KEY=sua_chave_aqui

# Release APK
flutter build apk --release \
  --dart-define=API_BASE_URL=https://api-registagro.onrender.com \
  --dart-define=TURNSTILE_SITE_KEY=sua_chave_aqui \
  --obfuscate --split-debug-info=build/symbols

# Release App Bundle (Play Store)
flutter build appbundle --release \
  --dart-define=API_BASE_URL=https://api-registagro.onrender.com \
  --dart-define=TURNSTILE_SITE_KEY=sua_chave_aqui \
  --obfuscate --split-debug-info=build/symbols

# Release IPA (App Store)
flutter build ipa --release \
  --dart-define=API_BASE_URL=https://api-registagro.onrender.com \
  --dart-define=TURNSTILE_SITE_KEY=sua_chave_aqui \
  --obfuscate --split-debug-info=build/symbols \
  --export-options-plist=ios/ExportOptions.plist
```

---

## Próximos passos quando API estiver pronta:

1. **Atualize `API_BASE_URL`** se mudou
2. **Rode testes de integração manualmente:**
   ```bash
   flutter test integration_test/app_test.dart \
     --dart-define=API_BASE_URL=https://api-registagro.onrender.com
   ```
3. **Ative workflow `integration-test`** no CI (remova `if: github.event_name == 'workflow_dispatch'`)
4. **Configure notificações** (Slack/Discord) se desejar