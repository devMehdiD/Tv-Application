import 'package:flutter/material.dart';
import '../widget/displayfilm.dart';

// ignore: must_be_immutable
class Seson extends StatefulWidget {
  dynamic id;
  Seson({Key? key, required this.id}) : super(key: key);

  @override
  _SesonState createState() => _SesonState();
}

class _SesonState extends State<Seson> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF460546),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFF460546),
        body: getsison(widget.id, context),
      ),
    );
  }
}
