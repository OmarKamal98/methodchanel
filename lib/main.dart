import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   Testt(),
    );
  }
}

class Testt extends StatefulWidget {
  const Testt({Key? key}) : super(key: key);

  @override
  State<Testt> createState() => _TesttState();
}

class _TesttState extends State<Testt> {
  TextEditingController controller = TextEditingController();
  String hijriDate = 'Null';

  MethodChannel convertToHijriChannel = MethodChannel('omarChanelName');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Method Channel'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: controller,
              //editing controller of this TextField
              decoration: InputDecoration(
                hintText: 'd/m/yyyy',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(12)),
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('d/M/yyyy').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    controller.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  convertToHijri(controller.text);
                });
              },
              child: Text('Calculate Hijri Date')),
          SizedBox(
            height: 50,
            key: UniqueKey(),
          ),
          Text('The Hijri Date Is :'),
          Text(
            hijriDate,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }

  Future convertToHijri(String datHijri) async{
    print('start get Date');
    final argument = {'hijriDate': datHijri};
    Map<String, String>? hijRiDateTime =
        await convertToHijriChannel.invokeMapMethod('convertToHijri', argument);
    String dateHijri = hijRiDateTime!['datee']!;
    String dateHijri1 = dateHijri.substring(19);
    hijriDate = dateHijri1;
    print(hijriDate);
    print('end');
  }
}
