import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/models/weather_data_hoult.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);
//card index
  RxInt cardindex = GlobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: const Text(
            "Today",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        hourlyList()
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherDataHourly.hourly.length > 12
              ? 12
              : weatherDataHourly.hourly.length,
          itemBuilder: (context, index) {
            return Obx((() => GestureDetector(
                onTap: () {
                  cardindex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0.5, 0),
                            blurRadius: 30,
                            spreadRadius: 1,
                            color: CustomColors.dividerLine.withAlpha(150))
                      ],
                      gradient: cardindex.value == index
                          ? const LinearGradient(colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor,
                            ])
                          : null),
                  child: HourlyDetails(
                      cardindex: cardindex.toInt(),
                      index: index,
                      date: weatherDataHourly.hourly[index].dt!,
                      temp: weatherDataHourly.hourly[index].temp!,
                      weatherIcon:
                          weatherDataHourly.hourly[index].weather![0].icon!),
                ))));
          }),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int date;
  int cardindex;
  int index;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.cardindex,
      required this.index,
      required this.date,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);
  String getTime(final Date) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(date),
            style: TextStyle(
                color: cardindex == index
                    ? Colors.white
                    : CustomColors.textColorBlack),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: TextStyle(
              color: cardindex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        )
      ],
    );
  }
}
