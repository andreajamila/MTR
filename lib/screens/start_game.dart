import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:gap/gap.dart';
import 'package:hulalalahanin/screens/game_screen.dart';
import 'package:hulalalahanin/models/data.dart';

class StartGame extends StatefulWidget {
  StartGame({super.key});

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  final controller = FlipCardController();
  List stritpuds = streetpuds;
  var taym1 = 0;
  var taym2 = 0;
  var taym3 = 0;
  var taym4 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow[200],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  //  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.asset(
                          "assets/images/bulb.png",
                          height: 100,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "HulAlalahanin!",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color: Colors.yellow[900]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Subukin ang memorya!",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(15),
            Text(
              "  Mga Kategorya",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.brown[900]),
            ),
            Expanded(
              child: GridView.count(
                scrollDirection: Axis.vertical,
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: .70,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      taym1 = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GameScreen(
                          mgaKard: stritpuds,
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange[400],
                      ),
                      child: Column(
                        children: [
                          Gap(20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/street_foods/tusok.png",
                              height: 130,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Tusok-tusok",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Text(
                            "Rekord: $taym1",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /////////////////
                  GestureDetector(
                    onTap: () async {
                      taym2 = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GameScreen(
                          mgaKard: putahe,
                        );
                      }));
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red[400],
                      ),
                      child: Column(
                        children: [
                          Gap(20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              "assets/images/putahes/putahe.png",
                              height: 130,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Putahe",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Text(
                            "Rekord: $taym2",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /////////////////
                  GestureDetector(
                    onTap: () async {
                      taym3 = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GameScreen(
                          mgaKard: memes,
                        );
                      }));
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[500],
                      ),
                      child: Column(
                        children: [
                          Gap(20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              "assets/images/cat.png",
                              height: 130,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Katatawanan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Text(
                            "Rekord: $taym3",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      taym4 = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GameScreen(
                          mgaKard: maligno,
                        );
                      }));
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          Gap(20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              "assets/images/multo.png",
                              height: 130,
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Kababalaghan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Text(
                            "Rekord: $taym4",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
