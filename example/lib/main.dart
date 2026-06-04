import 'package:flutter/material.dart';
import 'package:status_protocol/status_protocol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Protocol Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      appBar: AppBar(
        title: const Text('status_protocol'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader('Client Errors'),
          _StatusTile(code: 400),
          _StatusTile(code: 401),
          _StatusTile(code: 403),
          _StatusTile(code: 404),
          _StatusTile(code: 408),
          _StatusTile(code: 409),
          _StatusTile(code: 413),
          _StatusTile(code: 422),
          _StatusTile(code: 429),
          _SectionHeader('Server Errors'),
          _StatusTile(code: 500),
          _StatusTile(code: 502),
          _StatusTile(code: 503),
          _StatusTile(code: 504),
          _SectionHeader('Other'),
          _StatusTile(code: 0, label: 'No Internet'),
          _StatusTile(code: -1, label: 'Unknown Error'),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  final int code;
  final String? label;

  const _StatusTile({required this.code, this.label});

  @override
  Widget build(BuildContext context) {
    final config = resolve(code);
    return Card(
      color: const Color(0xFF1A1A1E),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          label ?? '${code} - ${config.title}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          config.message,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: config.accentColor, size: 16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StatusScreen(
                statusCode: code,
                onRetry: () => Navigator.of(context).pop(),
              ),
            ),
          );
        },
      ),
    );
  }
}
