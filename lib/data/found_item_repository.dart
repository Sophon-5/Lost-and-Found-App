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
    final String? raw = prefs.getString(_storageKey);
    final List<dynamic> list = raw == null || raw.isEmpty ? <dynamic>[] : jsonDecode(raw) as List<dynamic>;
    list.add(item.toJson());
    await prefs.setString(_storageKey, jsonEncode(list));
  }

  Future<void> delete(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return;
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    list.removeWhere((dynamic e) => (e as Map)['id'] == id);
    await prefs.setString(_storageKey, jsonEncode(list));
  }
}


