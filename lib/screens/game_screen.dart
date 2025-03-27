import 'dart:async';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hulalalahanin/models/data.dart';
import 'package:flip_card/flip_card.dart';
import 'package:hulalalahanin/screens/game_over_screen.dart';
import 'package:hulalalahanin/screens/start_game.dart';
import 'package:just_audio/just_audio.dart';

class GameScreen extends StatefulWidget {
  List mgaKard;
  GameScreen({super.key, required this.mgaKard});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _bgMusicPlayer = AudioPlayer();
  bool isMusicOn = true;
  bool isSoundOn = true;
  late List<FlipCardController> controllers = [];
  bool start = false;
  List<dynamic> kards = [];
  var controller = FlipCardController();
  List<int> flippedCards = []; // Track the indexes of the flipped cards
  bool canFlip = true;
  List<int> matchedCards =
      []; // Flag to prevent flipping until a match check is done
  int matchesLeft = 8;
  int taym = 0;
  late Timer durasyon;
  bool isFinished = false;

  List shuffledImages() {
    List shuffledImages = [];
    for (var element in widget.mgaKard) {
      shuffledImages.add(element);
    }
    shuffledImages.shuffle();
    return shuffledImages;
  }

  // Function to show the back face of each card briefly before flipping it back
  void showBackFaceAndFlipBack() {
    Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < controllers.length; i++) {
        controllers[i].toggleCard(); // Flip each card to the back
      }

      // After a brief delay, flip all the cards back to the front
      Future.delayed(const Duration(seconds: 6), () {
        for (int i = 0; i < controllers.length; i++) {
          controllers[i].toggleCard(); // Flip the card back to the front
        }
        start = true;
        startDuration();
      });
    });
  }

  // Function to check if two cards match
  void checkMatch() {
    if (flippedCards.length == 2) {
      int firstIndex = flippedCards[0];
      int secondIndex = flippedCards[1];

      if (widget.mgaKard[firstIndex] == widget.mgaKard[secondIndex]) {
        // If the cards match, add them to matchedCards and leave them face up
        setState(() {
          matchedCards.add(firstIndex);
          matchedCards.add(secondIndex);
          matchesLeft -= 1;
        });
        flippedCards.clear();
        print(flippedCards);
      } else {
        // If the cards don't match, flip them back after a short delay
        Future.delayed(const Duration(milliseconds: 700), () {
          controllers[firstIndex].toggleCard();
          controllers[secondIndex].toggleCard();
          // setState(() {
          flippedCards.clear();
          canFlip = true; // Allow flipping again
        });
        //  });
      }
    }
  }

  void startDuration() {
    durasyon = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        taym = (taym + 1);
      });
    });
  }

  Future<void> _playFlipSound() async {
    if (!isSoundOn) return; // Don't play if sound is off
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAsset('assets/sounds/card_sound.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing flip sound: $e");
    }
  }

  Future<void> _playBackgroundMusic() async {
    if (!isMusicOn) return;
    try {
      await _bgMusicPlayer.setAsset('assets/sounds/bg_music.mp3');
      _bgMusicPlayer.setLoopMode(LoopMode.one);
      await _bgMusicPlayer.play();
    } catch (e) {
      print("Error playing background music: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.mgaKard = shuffledImages();
    controllers =
        List.generate(widget.mgaKard.length, (index) => FlipCardController());
    showBackFaceAndFlipBack(); // Trigger the flipping behavior
    _playBackgroundMusic();
  }

  void _showPauseDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(""),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Icon(Icons.close))
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Music"),
                      Switch(
                        value: isMusicOn,
                        onChanged: (value) {
                          setDialogState(() {
                            isMusicOn = value;
                          });
                          if (isMusicOn) {
                            _playBackgroundMusic();
                          } else {
                            _bgMusicPlayer.stop();
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Flip Sound"),
                      Switch(
                        value: isSoundOn,
                        onChanged: (value) {
                          setDialogState(() {
                            isSoundOn = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (durasyon.isActive) {
                            durasyon.cancel();
                          }
                          _bgMusicPlayer.dispose();
                          _audioPlayer.dispose();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StartGame()));
                        },
                        child: Text("Ihinto ang laro"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            matchesLeft = 8;
                            durasyon.cancel();
                            taym = 0;
                            matchedCards.clear();
                            flippedCards.clear();
                            canFlip = true;
                            start = false;

                            for (var controller in controllers) {
                              if (controller.state?.isFront == false) {
                                controller.toggleCard();
                              }
                            }
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              setState(() {
                                widget.mgaKard = shuffledImages();
                                controllers = List.generate(
                                    widget.mgaKard.length,
                                    (index) => FlipCardController());
                                showBackFaceAndFlipBack();
                              });
                            });
                          });
                        },
                        child: Text("Ulitin ang laro"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void gameOver() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("GALING!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/wow.png"),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _bgMusicPlayer.dispose();
    _audioPlayer.dispose();
    durasyon.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: _showPauseDialog,
            child: Icon(
              Icons.settings,
              size: 40,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isFinished
            ? AlertDialog(
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/wow.png"),
                    Text(
                        "Natapos mo ang laro sa loob lamang ng $taym segundo!"),
                    ElevatedButton(
                      onPressed: () {
                        if (durasyon.isActive) {
                          durasyon.cancel(); // Siguraduhing icancel ang timer
                        }
                        _bgMusicPlayer.dispose();
                        _audioPlayer.dispose();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => StartGame()));
                        Navigator.of(context).pop(taym);
                      },
                      child: Text("Bumalik sa Home Screen"),
                    ),
                  ],
                ),
                actions: [],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Natitirang Pares: $matchesLeft',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Gap(15),
                  GridView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: widget.mgaKard.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FlipCard(
                            controller: controllers[index],
                            onFlip: () {
                              if (start && !matchedCards.contains(index)) {
                                // Prevent flipping matched cards
                                _playFlipSound();
                                setState(() {
                                  flippedCards.add(
                                      index); // Add the index to the flipped cards list
                                  canFlip =
                                      false; // Prevent flipping until we check for a match
                                });
                                checkMatch();
                              }
                              if (matchesLeft == 0) {
                                durasyon.cancel();
                                isFinished = true;
                                setState(() {});
                              }
                            },
                            flipOnTouch: !matchedCards.contains(index),
                            front: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.yellow[700],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            back: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              clipBehavior: Clip.hardEdge,
                              alignment: Alignment.center,
                              child: Image.asset(
                                widget.mgaKard[index],
                              ),
                            ),
                          ),
                        );
                      }),
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 50,
                      ),
                      Gap(20),
                      Text(
                        '${taym}s',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
