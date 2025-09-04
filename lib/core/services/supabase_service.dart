import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  late final SupabaseClient client;

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  /// Call this once (usually in main) to initialize Supabase for the app.
  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
    _instance.client = Supabase.instance.client;
  }

  /// Returns the prepared client instance for use throughout the app.
  SupabaseClient get supabaseClient => client;
}
