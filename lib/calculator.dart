
import 'constants.dart';

// Class untuk menghitung BMR dan kebutuhan kalori harian.
class Calculator {
  Calculator({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.activityLevel,
  });

  // Data yang dimasukkan oleh pengguna.
  final int height;
  final int weight;
  final int age;
  final Gender gender;
  final int activityLevel;

  double _bmr = 0.0;

  // Faktor aktivitas berdasarkan referensi Calculator.net.
  static const List<double> activityFactors = [
    1.2,
    1.375,
    1.465,
    1.55,
    1.725,
    1.9,
  ];

  // Nama tingkat aktivitas untuk ditampilkan pada aplikasi.
  static const List<String> activityNames = [
    'Sedentary: little or no exercise',
    'Exercise 1–3 times/week',
    'Exercise 4–5 times/week',
    'Daily exercise or intense exercise 3–4 times/week',
    'Intense exercise 6–7 times/week',
    'Very intense exercise daily or physical job',
  ];

  // Menghitung BMR menggunakan rumus Mifflin-St Jeor.
  String calculateBMR() {
    if (gender == Gender.male) {
      _bmr = (10 * weight) +
          (6.25 * height) -
          (5 * age) +
          5;
    } else {
      _bmr = (10 * weight) +
          (6.25 * height) -
          (5 * age) -
          161;
    }

    return _bmr.toStringAsFixed(1);
  }

  // Menghitung kebutuhan kalori sesuai tingkat aktivitas.
  double calculateDailyCalories() {
    // Pastikan indeks aktivitas berada dalam rentang yang tersedia.
    final int index = activityLevel.clamp(
      0,
      activityFactors.length - 1,
    );

    return _bmr * activityFactors[index];
  }

  // Menampilkan judul hasil.
  String getResult() {
    return 'YOUR BMR';
  }

  // Menjelaskan hasil BMR dan kebutuhan kalori harian.
  String getInterpretation() {
    final double dailyCalories = calculateDailyCalories();

    return 'Your estimated basal metabolic rate is '
        '${_bmr.toStringAsFixed(1)} kcal/day. '
        'Based on your selected activity level, '
        'your estimated daily calorie needs are '
        '${dailyCalories.round()} kcal/day.';
  }
}
