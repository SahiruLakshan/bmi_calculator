import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Page1(),
    debugShowCheckedModeBanner: false,
  ));
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI CALCULATOR'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.calculate)),
      ]),
      body: Center(
          child: Column(
        children: [
          const Image(
            image: AssetImage('images/real.png'),
            height: 600,
          ),
          ElevatedButton(
            child: const Text('Get Start'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: '',
                        )),
              );
            },
          ),
        ],
      )),
    );
  }
}

Gender? _gender;

enum Gender { Male, Female }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? currentDate;
  DateTime? selectedDate;
  int age = 0;

  DateTime? _picked;
  Future<void> _selectDate(BuildContext context) async {
    _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = _picked;
    });
  }

  int calculateAge(DateTime birthDate, DateTime currentDate) {
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  final TextEditingController _Controller = TextEditingController();
  final TextEditingController _Controller2 = TextEditingController();
  final TextEditingController _Controller3 = TextEditingController();
  final TextEditingController _Controller4 = TextEditingController();
  double _bmi = 0;
  String _name = '';
  String _address = '';
  String _result = '';

  void _resetValues() {
    setState(() {
      _Controller.clear();
      _Controller2.clear();
      _Controller3.clear();
      _Controller4.clear();
      _bmi = 0;
      _name = '';
      _address = '';
      _result = '';
      selectedDate = null;
      currentDate = null;
      age = 0;
    });
  }

  @override
  void dispose() {
    _Controller.dispose();
    _Controller2.dispose();
    super.dispose();
  }

  Future<void> _calculateResult() async {
    setState(() {
      double weight = double.tryParse(_Controller.text) ?? 0;
      double height = double.tryParse(_Controller2.text) ?? 0;
      _bmi = (weight / (height * height) * 10000);

      _name = _Controller3.text;
      _address = _Controller4.text;
    });

    if (_bmi < 18.5) {
      _result = 'YOU ARE UNDERWEIGHT!!';
    } else if (_bmi >= 18.5 && _bmi < 24.9) {
      _result = 'YOU ARE HEALTHY!!';
    } else if (_Controller.text == '' || _Controller2.text == '') {
      _result = 'ENTER WEIGHT AND HEIGHT';
    } else {
      _result = 'YOU ARE OVERWEIGHT!!';
    }

    if (_picked != null && _picked != currentDate) {
      setState(() {
        selectedDate = _picked;
        currentDate = DateTime.now();
        age = calculateAge(selectedDate!, currentDate!);
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BMI Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $_name',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Address: $_address',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Gender: ${_gender != null ? _gender.toString().split('.').last : ''}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your Age: $age years',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your BMI: ${_bmi.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                '$_result',
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('BMI CALCULATOR'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.calculate)),
      ]),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/he.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: const Text(
                'CALCULATE YOUR BMI',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _Controller3,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Enter UserName',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _Controller4,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Enter Address',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    'Gender:',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ListTile(
                        title: const Text('Male'),
                        leading: Radio<Gender>(
                          value: Gender.Male,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: ListTile(
                        title: const Text('Female'),
                        leading: Radio<Gender>(
                          value: Gender.Female,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    'Select Birthday:',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 20.0),
                              Text(
                                selectedDate != null
                                    ? selectedDate.toString().substring(0, 10)
                                    : 'Choose the Date',
                                style: const TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.only(
            //       right: 0), // Add padding to the container if desired
            //   child: Text(selectedDate != null
            //       ? 'Selected Birthday: ${selectedDate.toString().substring(0, 10)}'
            //       : ''),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Weight (kg)',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _Controller2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Height (cm)',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: Icon(Icons.height),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150.0,
                    child: ElevatedButton(
                      onPressed: _calculateResult,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    child: ElevatedButton(
                      onPressed: _resetValues,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black,
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Be Healthy and Happy!!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
