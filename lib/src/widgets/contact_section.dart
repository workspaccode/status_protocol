import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/contact_info.dart';

class ContactSection extends StatelessWidget {
  final ContactInfo contact;
  final ContactStyle? style;
  final Color? accentColor;
  final VoidCallback? onTapEmail;
  final VoidCallback? onTapPhone;
  final VoidCallback? onTapWebsite;

  const ContactSection({
    super.key,
    required this.contact,
    this.style,
    this.accentColor,
    this.onTapEmail,
    this.onTapPhone,
    this.onTapWebsite,
  });

  @override
  Widget build(BuildContext context) {
    final s = style;
    final accent = accentColor ?? Colors.white;
    final iconSize = s?.iconSize ?? 20;
    final iconColor = s?.iconColor ?? accent;
    final gap = s?.spacing ?? 12;

    return Padding(
      padding: s?.padding ?? const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          if (contact.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                contact.label!,
                style: s?.labelStyle ??
                    TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.5),
                      letterSpacing: 1.2,
                    ),
              ),
            ),
          if (contact.message != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                contact.message!,
                textAlign: TextAlign.center,
                style: s?.messageStyle ??
                    TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
              ),
            ),
          if (contact.email != null)
            _ContactLink(
              icon: Icons.email_outlined,
              label: contact.email!,
              iconSize: iconSize,
              iconColor: iconColor,
              linkStyle: s?.linkStyle,
              onTap: onTapEmail ??
                  () => Clipboard.setData(
                    ClipboardData(text: contact.email!),
                  ),
            ),
          if (contact.email != null && contact.phone != null)
            SizedBox(height: gap),
          if (contact.phone != null)
            _ContactLink(
              icon: Icons.phone_outlined,
              label: contact.phone!,
              iconSize: iconSize,
              iconColor: iconColor,
              linkStyle: s?.linkStyle,
              onTap: onTapPhone ??
                  () => Clipboard.setData(
                    ClipboardData(text: contact.phone!),
                  ),
            ),
          if (contact.website != null) ...[
            SizedBox(height: gap),
            _ContactLink(
              icon: Icons.language_outlined,
              label: contact.website!,
              iconSize: iconSize,
              iconColor: iconColor,
              linkStyle: s?.linkStyle,
              onTap: onTapWebsite ??
                  () => Clipboard.setData(
                    ClipboardData(text: contact.website!),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ContactLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  final Color iconColor;
  final TextStyle? linkStyle;
  final VoidCallback onTap;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.iconSize,
    required this.iconColor,
    this.linkStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: linkStyle ??
                TextStyle(
                  fontSize: 14,
                  color: iconColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ],
      ),
    );
  }
}
