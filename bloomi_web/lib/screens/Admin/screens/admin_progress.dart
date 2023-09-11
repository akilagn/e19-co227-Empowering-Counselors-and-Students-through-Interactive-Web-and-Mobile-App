import 'package:bloomi_web/components/background_color_gradient.dart';
import 'package:bloomi_web/components/custom_text.dart';
import 'package:flutter/material.dart';

class AdminProgress extends StatefulWidget {
  const AdminProgress({super.key});

  @override
  State<AdminProgress> createState() => _AdminProgressState();
}

class _AdminProgressState extends State<AdminProgress> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: CustomText("Admin Progress"),
          ),
          BackgroundColorGradient()
        ],
      ),
    );
  }
}
