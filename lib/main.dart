import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String second = "00", minute = "00", hour = "00";
  Timer? timer;
  bool started = false;
  List laps = [];
  //stop method
  void stop() {
    setState(() {
      timer!.cancel();
      started = false;
    });
  }

// reset method
  void reset() {
    setState(() {
      timer!.cancel();
      started = false;

      seconds = 0;
      minutes = 0;
      hours = 0;

      second = "00";
      minute = "00";
      hour = "00";
    });
  }

// add laps
  void addLaps() {
    String lap = "$second:$minute:$hour";
    setState(() {
      laps.add(lap);
    });
  }
// start function

  void start() {
    
      started = true;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        int localSeconds = seconds + 1;
        int localMinutes = minutes;
        int localHours = hours;

        if (localSeconds > 59) {
          localSeconds = 0;
          if (localMinutes > 59) {
            localMinutes = 0;
            localHours++;
          } else {
            localMinutes++;
          }
        }
        setState(() {

        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        
        second = (seconds >= 10) ? "$seconds" : "0$seconds";
        minute = (minutes >= 10) ? "$minutes" : "0$minutes";
        hour = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Stopwatch',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Text(
                    "$hour:$minute:$second",
                    style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 420.0,
                  width: 390.0,
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                  ),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lap $index',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                            Text(
                              '${laps[index]}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        fillColor: Colors.blue,
                        hoverElevation: 30,
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () {
                          (!started) ? start() : stop();
                        },
                        child: Text(
                          (!started) ? "Start" : "Stop",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon: const Icon(Icons.flag),
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RawMaterialButton(
                        fillColor: Colors.blue,
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () {
                          reset();
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
