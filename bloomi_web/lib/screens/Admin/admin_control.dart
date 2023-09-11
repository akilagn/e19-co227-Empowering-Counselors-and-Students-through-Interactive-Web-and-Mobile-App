import 'package:bloomi_web/components/custom_text.dart';
import 'package:flutter/material.dart';

class AdminControl extends StatefulWidget {
  const AdminControl({super.key});

  @override
  State<AdminControl> createState() => _AdminControlState();
}

class _AdminControlState extends State<AdminControl> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText("Admin Control"),
    );
  }
}