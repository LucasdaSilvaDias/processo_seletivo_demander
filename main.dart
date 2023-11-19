import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  TextEditingController _controller = TextEditingController();
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
        centerTitle: true,
        title: Text('Conversor Romano-Arábico'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Insira um número'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = arabicToRoman(int.parse(_controller.text));
                    });
                  },
                  child: Text('Arábico para Romano'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = romanToArabic(_controller.text).toString();
                    });
                  },
                  child: Text('Romano para Arábico'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: $_result',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  String arabicToRoman(int number) {
    if (number < 1 || number > 9999999999) {}

    final List<String> romanNumerals = [
      'I',
      'IV',
      'V',
      'IX',
      'X',
      'XL',
      'L',
      'XC',
      'C',
      'CD',
      'D',
      'CM',
      'M'
    ];
    final List<int> arabicValues = [
      1,
      4,
      5,
      9,
      10,
      40,
      50,
      90,
      100,
      400,
      500,
      900,
      1000
    ];

    String result = '';

    for (int i = arabicValues.length - 1; i >= 0; i--) {
      while (number >= arabicValues[i]) {
        result += romanNumerals[i];
        number -= arabicValues[i];
      }
    }

    return result;
  }
}

int romanToArabic(String roman) {
  final Map<String, int> romanNumerals = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000
  };

  int result = 0;
  int previousValue = 0;

  for (int i = roman.length - 1; i >= 0; i--) {
    int value = romanNumerals[roman[i]]!;

    if (value < previousValue) {
      result -= value;
    } else {
      result += value;
    }

    previousValue = value;
  }

  return result;
}
