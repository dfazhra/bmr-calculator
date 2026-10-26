
import 'package:flutter/material.dart';

import '../components/custom_card.dart';
import '../components/bottom_button.dart';
import '../constants.dart';
import '../calculator.dart';

// Halaman untuk menampilkan hasil perhitungan BMR
// dan estimasi kebutuhan kalori berdasarkan aktivitas.
class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.bmr,
    required this.information,
    required this.dailyCalories,
    required this.activityName,
  });

  // Data yang dikirim dari halaman input.
  final String result;
  final String bmr;
  final String information;
  final double dailyCalories;
  final String activityName;

  @override
  Widget build(BuildContext context) {
    // Mengubah hasil BMR dari String menjadi double
    // agar dapat digunakan untuk menghitung kalori.
    final double bmrValue = double.tryParse(bmr) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR CALCULATOR'),
      ),

      // SingleChildScrollView digunakan agar halaman
      // dapat digulir ketika kontennya terlalu panjang.
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Judul halaman hasil.
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Your Result',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Card untuk menampilkan hasil BMR.
                    CustomCard(
                      color: activeCardColor,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),

                            // Judul hasil BMR.
                            Text(
                              result,
                              style: resultTextStyle,
                            ),

                            const SizedBox(height: 20),

                            // Menampilkan angka BMR.
                            Text(
                              bmr,
                              style: const TextStyle(
                                fontSize: 64.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              'BMR (kcal/day)',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF8D8E98),
                              ),
                            ),

                            const SizedBox(height: 25),
                            const Divider(color: Colors.white24),
                            const SizedBox(height: 20),

                            // Tingkat aktivitas yang dipilih.
                            Text(
                              activityName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF24D876),
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Estimated Daily Calorie Needs',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),

                            const SizedBox(height: 12),

                            // Hasil kebutuhan kalori harian.
                            Text(
                              '${dailyCalories.round()} kcal/day',
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 25),

                            // Penjelasan hasil perhitungan.
                            Text(
                              information,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15.0,
                              ),
                            ),

                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Judul tabel kebutuhan kalori.
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'Daily Calorie Needs Based on Activity Level',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Tabel enam tingkat aktivitas.
                    CustomCard(
                      color: activeCardColor,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            // Header tabel.
                            Container(
                              padding: const EdgeInsets.all(12),
                              color: const Color(0xFF252A50),
                              child: const Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Activity Level',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Calories',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Membuat enam baris tabel otomatis
                            // menggunakan daftar aktivitas dari Calculator.
                            ...List.generate(
                              Calculator.activityNames.length,
                              (index) {
                                // Menghitung kebutuhan kalori
                                // berdasarkan faktor aktivitas.
                                final double calories =
                                    bmrValue *
                                    Calculator.activityFactors[index];

                                // Menandai aktivitas yang dipilih.
                                final bool isSelected =
                                    activityName ==
                                    Calculator.activityNames[index];

                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF252A50)
                                        : Colors.transparent,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: Colors.white12,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Nama aktivitas.
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          Calculator.activityNames[index],
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isSelected
                                                ? const Color(0xFF24D876)
                                                : Colors.white,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      // Jumlah kalori per hari.
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '${calories.round()}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? const Color(0xFF24D876)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Keterangan tambahan.
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Note: These results are estimates based on '
                        'the Mifflin-St Jeor equation and activity factors. '
                        'Actual calorie needs may vary.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8D8E98),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol kembali ke halaman input.
            BottomButton(
              buttonTitle: 'RE-CALCULATE',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
