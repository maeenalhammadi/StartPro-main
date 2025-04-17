import 'package:start_pro/core/providers/color_hunt_provider.dart';

void main() async {
  final ColorHunt colorHunt = ColorHunt();

  final colors = await colorHunt.getColors();
  print(colors);
}

