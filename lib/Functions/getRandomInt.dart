import 'dart:math';

int getRandomInt(max) {
  Random random = Random.secure();
  return random.nextInt(max);
}