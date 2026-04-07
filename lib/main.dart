import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coredesk/config/dependencies.dart';
import 'package:coredesk/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Dependencies.initialize(prefs);
  runApp(const CoreDeskApp());
}
