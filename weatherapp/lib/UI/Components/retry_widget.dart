import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final String error;
  final Function() reload;

  const RetryWidget({super.key, required this.error, required this.reload});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: reload,
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}
