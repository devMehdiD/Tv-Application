// ignore_for_file: non_constant_identifier_names

import 'package:films/pages/desplayepsoide.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import '../sesonfilm/sesonfilm.dart';

Widget FilmsList(
  BuildContext context,
  ScrollController controller,
) {
  final size = MediaQuery.of(context).size;
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: controller,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final film = data[index];
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
                  child: Seson(
                    id: film['id'],
                  ),
                );
              }));
            },
            child: SizedBox(
              width: size.width * 0.34,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.25,
                      width: size.width * 0.34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) =>
                                const CircularProgressIndicator(),
                            image: NetworkImage(
                              "${film['imagemovies']}",
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        film['title'],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}

Widget BuildWatching(
  BuildContext context,
) {
  final size = MediaQuery.of(context).size;
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.6),
      itemCount: data2.length,
      itemBuilder: (context, index) {
        final film = data2[index];
        return SizedBox(
          width: size.width * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.25,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) =>
                            const CircularProgressIndicator(),
                        image: NetworkImage(
                          "${film['image']}",
                        ),
                      )),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

getsison(id, BuildContext context) {
  var getdata = data[id]['seaseons']['image'];
  final size = MediaQuery.of(context).size;
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 10),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: getdata.length,
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
                  child: DesplayEpsoid(
                    episodes: getdata[index]['episodes'],
                    imageseason: getdata[index]['imageseason'][0],
                  ),
                );
              }));
            },
            child: SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Flexible(
                      child: Container(
                        height: 200,
                        width: size.width * 0.34,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) =>
                                  const CircularProgressIndicator(),
                              image: NetworkImage(
                                "${getdata[index]['imageseason'][0]}",
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        "S${index + 1}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}
