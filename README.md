# status_protocol

A plug-and-play Flutter package for handling HTTP status code UI states with SVG illustrations, messages, and action buttons.

[![pub package](https://img.shields.io/badge/pub-v1.0.0-blue)](https://pub.dev/packages/status_protocol)
[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue)](https://flutter.dev)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

## Features

- **StatusScreen** — Full-page error screen for any HTTP status code
- **StatusBanner** — Compact inline banner for in-screen errors
- **SVG illustrations** — Per-status illustrations with icon fallback
- **Customizable** — Override title, message, button, colors, SVGs
- **Themeable** — Global theme via `StatusProtocolProvider`
- **Framework agnostic** — Works with BLoC, Riverpod, Provider, GetX
- **All HTTP codes** — 400–504, plus no-internet and unknown fallback

## Install

```yaml
dependencies:
  status_protocol: ^1.0.0
```

## Usage

### Full-screen error

```dart
StatusScreen(
  statusCode: 404,
  onRetry: () => myApiCall(),
)
```

### Inline banner

```dart
StatusBanner(
  statusCode: 429,
  onRetry: () {},
  onDismiss: () {},
)
```

### Custom overrides

```dart
StatusScreen(
  statusCode: 500,
  onRetry: () {},
  title: 'Custom Title',
  message: 'Custom message',
  buttonLabel: 'Try Again',
  backgroundColor: Colors.black,
  accentColor: Colors.deepPurple,
  showButton: true,
  svgAsset: 'assets/svg/500.svg',
  customButton: MyCustomButton(),
)
```

### Multiple action buttons

Pass a `List<StatusButton>` to `buttons` to show any number of buttons. Each
button has its own `onPressed` action and a `type` (`elevated`, `outlined`, or
`text`). By default they are laid out in a **row**; set `showColumnButtons: true`
to stack them in a **column**.

```dart
StatusScreen(
  statusCode: 503,
  showColumnButtons: true, // false (default) = row, true = column
  buttons: const [
    StatusButton(
      label: 'Retry',
      type: StatusButtonType.elevated,
      onPressed: _retry,
    ),
    StatusButton(
      label: 'Contact Support',
      type: StatusButtonType.outlined,
      onPressed: _openSupport,
    ),
    StatusButton(
      label: 'Dismiss',
      type: StatusButtonType.text,
      onPressed: _dismiss,
    ),
  ],
)
```

`StatusButton` fields:

| Field | Type | Description |
|-------|------|-------------|
| `label` | `String` | Button text (required) |
| `onPressed` | `VoidCallback?` | Action for this specific button |
| `type` | `StatusButtonType` | `elevated` (default), `outlined`, or `text` |
| `accentColor` | `Color?` | Per-button color override; falls back to `accentColor` |

When `buttons` is omitted, a single default button is still built from
`buttonLabel` / `onRetry` (backward compatible).

### With StatusProtocolProvider (global theme)

```dart
MaterialApp(
  home: StatusProtocolProvider(
    backgroundColor: Color(0xFF0D0D0F),
    useSvg: true,
    child: MyApp(),
  ),
)
```

### In a FutureBuilder

```dart
FutureBuilder(
  future: myApi.getData(),
  builder: (ctx, snap) {
    if (snap.hasError) {
      final code = (snap.error as ApiException).statusCode;
      return StatusScreen(statusCode: code, onRetry: refetch);
    }
    return MyDataWidget(snap.data);
  },
)
```

### With Dio interceptor

```dart
dio.interceptors.add(InterceptorsWrapper(
  onError: (e, handler) {
    final code = e.response?.statusCode ?? 0;
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => StatusScreen(
          statusCode: code,
          onRetry: () => navigatorKey.currentState?.pop(),
        ),
      ),
    );
  },
));
```

## Status Codes

| Code | Title | Button |
|------|-------|--------|
| 400 | Bad Request | Fix & Retry |
| 401 | Unauthorized | Login Again |
| 403 | Forbidden | Go Back |
| 404 | Not Found | Go Home |
| 408 | Request Timeout | Retry |
| 409 | Conflict | Retry |
| 413 | File Too Large | Try Smaller File |
| 422 | Validation Error | Fix Fields |
| 429 | Too Many Requests | Wait & Retry |
| 500 | Server Error | Try Again |
| 502 | Bad Gateway | Retry |
| 503 | Unavailable | Check Status |
| 504 | Gateway Timeout | Try Again |
| 0 | No Internet | Retry |
| -1 | Unknown Error | Try Again |

## SVG Assets

Place your SVG files in `assets/svg/` matching the code names:

```
assets/svg/
├── noInternet.svg   (used for 0, -1, 4xx/5xx fallback)
├── 401.svg
├── 403.svg
├── 404.svg
├── 429.svg
├── 500.svg
├── 503.svg
├── 504.svg
```

Missing per-code SVGs fall back to `noInternet.svg`. To add a dedicated SVG, create e.g. `400.svg`, `408.svg`, etc. — they'll be picked up automatically.

## License

MIT
