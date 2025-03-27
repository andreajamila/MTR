import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:hulalalahanin/models/data.dart';
import 'package:flip_card/flip_card.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<FlipCardController> controllers = [];
  bool start = false;
  List<dynamic> streetfuds = [];
  List<int> flippedCards = []; // Track the indexes of the flipped cards
  List<int> matchedCards = []; // Track matched cards
  bool canFlip = true; // Flag to prevent flipping until a match check is done

  List shuffledImages() {
    List shuffledImages = [];
    for (var element in streetpuds) {
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
      });
    });
  }

  // Function to check if two cards match
  void checkMatch() {
    if (flippedCards.length == 2) {
      int firstIndex = flippedCards[0];
      int secondIndex = flippedCards[1];

      if (streetfuds[firstIndex] == streetfuds[secondIndex]) {
        // If the cards match, add them to matchedCards and leave them face up
        setState(() {
          matchedCards.add(firstIndex);
          matchedCards.add(secondIndex);
          flippedCards.clear();
        });
      } else {
        // If the cards don't match, flip them back after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          controllers[firstIndex].toggleCard();
          controllers[secondIndex].toggleCard();
          setState(() {
            flippedCards.clear();
            canFlip = true; // Allow flipping again
          });
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    streetfuds = shuffledImages();
    controllers =
        List.generate(streetfuds.length, (index) => FlipCardController());
    showBackFaceAndFlipBack(); // Trigger the flipping behavior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.75,
              ),
              itemCount: streetfuds.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FlipCard(
                    controller: controllers[index],
                    onFlip: () {
                      if (start && !matchedCards.contains(index)) {
                        // Prevent flipping matched cards
                        setState(() {
                          flippedCards.add(
                              index); // Add the index to the flipped cards list
                          canFlip =
                              false; // Prevent flipping until we check for a match
                        });
                        checkMatch();
                      }
                    },
                    flipOnTouch: !matchedCards
                        .contains(index), // Disable flip for matched cards
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
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Image.asset(streetfuds[index]),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
