import 'package:flutter/material.dart';

class ArenaPage extends StatefulWidget {
  @override
  _ArenaPageState createState() => _ArenaPageState();
}

class _ArenaPageState extends State<ArenaPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Arena')),
        body: const Center(
          child: Text('Arena Page'),
        ),
      );
}
