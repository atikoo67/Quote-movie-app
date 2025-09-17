import 'package:flutter/material.dart';

class Downloads extends StatefulWidget {
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Downloads', style: theme.textTheme.bodyMedium),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('No Downloads', style: theme.textTheme.bodySmall),
            ),
          ),
        ],
      ),
    );
  }
}
