import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import '../widget/displayfilm.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF460546),
      body: ListView(children: [
        Container(
          height: size.height / 4,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://images.bfmtv.com/9S3W1949cmz2rAIxh9HtW-QTax4=/4x3:1252x705/640x0/images/-188917.jpg",
                  ))),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Avengers: Endgame",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: size.width * 0.05),
                ),
                Row(
                  children: [
                    Row(
                        children: List.generate(
                            5,
                            (index) => const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ))),
                    const Text("4.9")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.play_arrow,
                            ),
                            Text("Playe"),
                          ],
                        )),
                    Row(
                      children: [
                        cardwidgte(Icon(
                          FontAwesome.heart,
                          color: Colors.white.withOpacity(0.7),
                        )),
                        cardwidgte(Icon(
                          FontAwesome.download,
                          color: Colors.white.withOpacity(0.7),
                        )),
                        cardwidgte(Icon(
                          FontAwesome.minus,
                          color: Colors.white.withOpacity(0.7),
                        ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: size.height * 0.02,
            child: const Text(
              "Popilaire write now",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        SizedBox(
            height: size.height * 0.3,
            width: size.width,
            child: FilmsList(context, controller)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: size.height * 0.02,
            child: const Text(
              "Continue Watching",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        SizedBox(
            height: size.height * 0.3,
            width: size.width,
            child: BuildWatching(context)),
      ]),
    ));
  }

  Widget cardwidgte(Icon icon) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.purple,
      child: SizedBox(
        height: size.height * 0.05,
        width: size.height * 0.05,
        child: IconButton(
          icon: icon,
          onPressed: () {},
        ),
      ),
    );
  }
}
