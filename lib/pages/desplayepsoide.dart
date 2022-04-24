import 'dart:isolate';
import 'dart:ui';

import 'package:films/pages/playfilm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DesplayEpsoid extends StatefulWidget {
  List<String> episodes;
  String imageseason;
  DesplayEpsoid({Key? key, required this.episodes, required this.imageseason})
      : super(key: key);

  @override
  _DesplayEpsoidState createState() => _DesplayEpsoidState();
}

class _DesplayEpsoidState extends State<DesplayEpsoid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
    _controller.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF460546),
        appBar: AppBar(
          backgroundColor: Color(0xFF460546),
          elevation: 0,
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.episodes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageRouteBuilder<Offset>(
                        pageBuilder: (context, animation, secondaryAnimation) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                          position: offsetAnimation,
                          child: PlayFilm(url: widget.episodes[index]));
                    }));
                  },
                  child: SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                              height: 400,
                              width: size.width * 0.34,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    onError: (exception, stackTrace) =>
                                        const CircularProgressIndicator(),
                                    image: NetworkImage(widget.imageseason),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "episodes ${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                                IconButton(
                                    onPressed: () {
                                      download(widget.episodes[index]);
                                    },
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }

  download(url) async {
    if (await Permission.storage.request().isDenied) {
      await Permission.storage.request();
    } else if (await Permission.storage.request().isGranted) {
      final Storage = await getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: Storage!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } else {
      print("No permision Granted");
    }
  }
}
