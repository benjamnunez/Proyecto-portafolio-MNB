import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://xjrxihpqoqmecetwpaua.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqcnhpaHBxb3FtZWNldHdwYXVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxNzQ5NDcsImV4cCI6MjA1Nzc1MDk0N30.13n-n8dm8sll0HwYll_8w8JQy-hQGD0-SBQ75iRY5wE';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}