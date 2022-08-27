import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/widgets/comfort_level.dart';
import 'package:weatherapp_starter_project/widgets/current_weather.dart';
import 'package:weatherapp_starter_project/widgets/daily_data_forecast.dart';
import 'package:weatherapp_starter_project/widgets/header_widget.dart';
import 'package:weatherapp_starter_project/widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkloading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    // for current temp ('current')
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getWeatherData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                      weatherDataHourly:
                          globalController.getWeatherData().getHourlyWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getWeatherData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather())
                  ],
                ),
        ),
      ),
    );
  }
}
