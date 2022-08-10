import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static UniqueKey key1 = UniqueKey();
  static UniqueKey key2 = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  List<Widget> emojis = [
    GetEmoji(
      emg: "😎",
      key: key1,
    ),
    GetEmoji(
      emg: "🤠",
      key: key2,
    )
  ];
  swapEmoji() {
    print("This is key1 $key1 - $key2");
    setState(() {
      emojis.insert(1, emojis.removeAt(0));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: emojis),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: swapEmoji,
                child: const Text("Swap"),
              )
            ],
          ),
        ));
  }
}

class GetEmoji extends StatelessWidget {

  GetEmoji({required this.emg, required this.key});

  final key;
  String emg;
  @override
  @override
  Widget build(BuildContext context) {
    return Text(
      emg,
      style: const TextStyle(
        fontSize: 100,
      ),
      key: key,
    );
  }
}