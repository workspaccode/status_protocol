## 1.0.0

- Initial release.
- `StatusScreen` — full-page error widget for any HTTP status code.
- `StatusBanner` — compact inline banner for in-screen errors.
- SVG illustrations with `flutter_svg` and icon fallback.
- `StatusProtocolProvider` / `StatusProtocolTheme` for global theming.
- `ContactInfo` / `ContactStyle` — built-in contact section with email, phone, and website.
- Built-in configs for 13 HTTP error codes + no-internet + unknown fallback.
- Customizable title, message, button label, colors, SVG asset, contact, and button.
- Range-based fallback: unknown 4xx → generic client error, 5xx → server error.
- Works with any state management (BLoC, Riverpod, Provider, GetX).
