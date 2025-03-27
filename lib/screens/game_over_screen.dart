import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hulalalahanin/screens/extra_code.dart';

class GameOverScreen extends StatefulWidget {
  final int duration;
  const GameOverScreen({super.key, required this.duration});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 12),
  );
  bool ulitin = false;
  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final theme = Theme.of(context).textTheme;
    return ulitin
        ? GameScreen()
        : Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Natapos mo sa loob ng"),
                      Text("${widget.duration} segundo"),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("ANG GALING!"),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ulitin = true;
                          setState(() {});
                        },
                        child: const Text("Replay Game"),
                      ),
                    ],
                  ),
                ),
                ConfettiWidget(
                  numberOfParticles: 30,
                  minBlastForce: 10,
                  maxBlastForce: 20,
                  blastDirectionality: BlastDirectionality.explosive,
                  confettiController: _confettiController,
                  gravity: 0.1,
                ),
              ],
            ),
          );
  }
}
