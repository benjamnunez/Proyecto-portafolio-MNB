import 'package:flutter/material.dart';
import 'package:gymhub/presentation/app.dart';
import 'package:gymhub/services/supabase_config.dart';



void main() async{
  await SupabaseConfig.initialize();
  runApp(const MyApp());
}

