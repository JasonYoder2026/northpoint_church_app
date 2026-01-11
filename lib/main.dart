import 'package:flutter/material.dart';
import 'package:northpoint_church_app/app.dart';
import 'package:northpoint_church_app/core/config/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initSupabase();

  runApp(const App());
}
