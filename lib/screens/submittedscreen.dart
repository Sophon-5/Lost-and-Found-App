import 'package:flutter/material.dart';

class SubmittedScreen extends StatelessWidget {
  const SubmittedScreen({super.key});

  static const String routeName = '/submitted';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: const Text('Success'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFECF0FF),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(Icons.check_rounded, color: Color(0xFF6C63FF), size: 72),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Submitted Successfully',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your report has been recorded. Thank you for helping!',
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Go back to Home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


