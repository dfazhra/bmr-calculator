
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/custom_card.dart';
import '../components/icon_card.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import '../constants.dart';
import '../calculator.dart';
import 'result_page.dart';

// Halaman input untuk menghitung BMR.
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Nilai awal data pengguna.
  Gender selectedGender = Gender.male;
  int height = 160;
  int weight = 60;
  int age = 20;
  int selectedActivity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR CALCULATOR'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Memilih jenis kelamin.
              SizedBox(
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        color: selectedGender == Gender.male
                            ? activeCardColor
                            : inactiveCardColor,
                        cardChild: const IconCard(
                          cardIcon: FontAwesomeIcons.mars,
                          caption: 'MALE',
                        ),
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        color: selectedGender == Gender.female
                            ? activeCardColor
                            : inactiveCardColor,
                        cardChild: const IconCard(
                          cardIcon: FontAwesomeIcons.venus,
                          caption: 'FEMALE',
                        ),
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Mengatur tinggi badan.
              CustomCard(
                color: activeCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('HEIGHT', style: labelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(height.toString(), style: numberTextStyle),
                        const Text(' cm', style: labelTextStyle),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF197CFD),
                        inactiveTrackColor: const Color(0xFF454967),
                        thumbColor: const Color(0xFF197CFD),
                        overlayColor: const Color(0x33197CFD),
                        trackHeight: 5,
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120,
                        max: 220,
                        onChanged: (value) {
                          setState(() {
                            height = value.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Mengatur berat badan dan usia.
              SizedBox(
                height: 220,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: _buildCounter(
                          title: 'WEIGHT',
                          value: weight,
                          unit: 'kg',
                          onMinus: () {
                            if (weight > 1) {
                              setState(() => weight--);
                            }
                          },
                          onPlus: () {
                            setState(() => weight++);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: _buildCounter(
                          title: 'AGE',
                          value: age,
                          unit: 'years',
                          onMinus: () {
                            if (age > 15) {
                              setState(() => age--);
                            }
                          },
                          onPlus: () {
                            if (age < 80) {
                              setState(() => age++);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Memilih tingkat aktivitas harian.
              Padding(
                padding: const EdgeInsets.all(12),
                child: CustomCard(
                  color: activeCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ACTIVITY LEVEL',
                          style: labelTextStyle,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<int>(
                          initialValue: selectedActivity,
                          isExpanded: true,
                          dropdownColor: const Color(0xFF1D1E33),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF454967),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF197CFD),
                                width: 2,
                              ),
                            ),
                          ),
                          items: List.generate(
                            Calculator.activityNames.length,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(
                                Calculator.activityNames[index],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedActivity = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Menghitung BMR dan membuka halaman hasil.
              BottomButton(
                buttonTitle: 'CALCULATE BMR',
                onTap: () {
                  final calculator = Calculator(
                    height: height,
                    weight: weight,
                    age: age,
                    gender: selectedGender,
                    activityLevel: selectedActivity,
                  );

                  final String bmr = calculator.calculateBMR();
                  final String result = calculator.getResult();
                  final String information =
                      calculator.getInterpretation();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        result: result,
                        bmr: bmr,
                        information: information,
                        dailyCalories:
                            calculator.calculateDailyCalories(),
                        activityName:
                            Calculator.activityNames[selectedActivity],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk tombol tambah dan kurang berat badan atau usia.
  Widget _buildCounter({
    required String title,
    required int value,
    required String unit,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: labelTextStyle),
        Text(value.toString(), style: numberTextStyle),
        Text(unit, style: const TextStyle(color: Colors.white70)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundIconButton(
              icon: FontAwesomeIcons.minus,
              onPressed: onMinus,
            ),
            const SizedBox(width: 8),
            RoundIconButton(
              icon: FontAwesomeIcons.plus,
              onPressed: onPlus,
            ),
          ],
        ),
      ],
    );
  }
}
