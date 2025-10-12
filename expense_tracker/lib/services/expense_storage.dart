import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseStorage {
  static const _kKey = 'expenses_v1';

  static Future<void> saveAll(List<Expense> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(_kKey, encoded);
  }

  static Future<List<Expense>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_kKey);
    if (data == null || data.isEmpty) return [];
    try {
      final List<dynamic> list = jsonDecode(data);
      return list.map((m) => Expense.fromJson(m as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kKey);
  }
}
