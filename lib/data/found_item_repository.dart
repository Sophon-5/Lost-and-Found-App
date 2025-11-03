import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/found_item.dart';

class FoundItemRepository {
  FoundItemRepository._internal();
  static final FoundItemRepository instance = FoundItemRepository._internal();

  static const String _storageKey = 'found_items_v1';

  Future<List<FoundItem>> getAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return <FoundItem>[];
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => FoundItem.fromJson((e as Map).cast<String, dynamic>()))
        .toList()
        .reversed
        .toList();
  }

  Future<void> add(FoundItem item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<FoundItem> existing = await getAll();
    final List<FoundItem> updated = <FoundItem>[...existing.reversed, item];
    final String raw = jsonEncode(updated.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, raw);
  }

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}


