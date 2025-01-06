import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../weather/ui/widgets/main_screen/weather_screen.dart';
import '../../weather/ui/widgets/main_screen/weather_screen_model.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: ChangeNotifierProvider(
        child: HelperWeatherScreen(),
        create: (_) => WeatherScreenModel(),
        lazy: false,
      ),
    );
  }
}
