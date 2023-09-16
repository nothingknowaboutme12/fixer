// Play a crack sound when a button is pressed
import 'package:fixer/main.dart';

// Play a crack sound when a button is pressed
Future<void> playDripSound() async {
  await audioPlayer.setAsset('assets/sounds/drip_sound.mp3');
  await audioPlayer.play();
}

Future<void> playCrackSound() async {
  await audioPlayer.setAsset('assets/sounds/crack.wav');
  await audioPlayer.play();
}
