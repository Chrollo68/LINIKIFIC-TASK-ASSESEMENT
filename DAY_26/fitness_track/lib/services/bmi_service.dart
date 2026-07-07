import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BmiMetrics {
  final double bmi;
  final double weight;
  final double height;

  BmiMetrics({required this.bmi, required this.weight, required this.height});

  Map<String, dynamic> toJson() => {
    'bmi': bmi,
    'weight': weight,
    'height': height,
  };

  factory BmiMetrics.fromJson(Map<String, dynamic> json) => BmiMetrics(
    bmi: (json['bmi'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
  );
}

class BmiService {
  BmiService._();
  static final BmiService instance = BmiService._();

  static String _keyFor(String userKey) => 'bmi_metrics_$userKey';

  double computeBmi({required double weightKg, required double heightCm}) {
    if (heightCm <= 0) return 0.0;
    final heightM = heightCm / 100.0;
    return weightKg / (heightM * heightM);
  }

  Future<void> saveMetrics(
    String userKey, {
    required double weightKg,
    required double heightCm,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final bmi = computeBmi(weightKg: weightKg, heightCm: heightCm);
    final metrics = BmiMetrics(bmi: bmi, weight: weightKg, height: heightCm);
    await prefs.setString(_keyFor(userKey), jsonEncode(metrics.toJson()));
  }

  Future<BmiMetrics?> getMetrics(String userKey) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyFor(userKey));
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return BmiMetrics.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearMetrics(String userKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyFor(userKey));
  }
}
