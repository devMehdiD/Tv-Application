import 'package:flutter/cupertino.dart';

class DownloadPgae extends StatefulWidget {
  const DownloadPgae({Key? key}) : super(key: key);

  @override
  _DownloadPgaeState createState() => _DownloadPgaeState();
}

class _DownloadPgaeState extends State<DownloadPgae>
    with SingleTickerProviderStateMixin {
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
    return Container();
  }
}
