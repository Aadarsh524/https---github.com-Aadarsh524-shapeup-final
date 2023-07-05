import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepsTracker extends StatefulWidget {
  @override
  _StepsTrackerState createState() => _StepsTrackerState();
}

class _StepsTrackerState extends State<StepsTracker> {
  late StreamSubscription<StepCount> _stepCountSubscription;
  late StreamSubscription<PedestrianStatus> _pedestrianStatusSubscription;
  String _status = '?';
  int _totalSteps = 0;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  void onStepCount(StepCount event) {
    if (mounted) {
      setState(() {
        _totalSteps = event.steps;
      });
    }
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    if (mounted) {
      setState(() {
        _status = event.status;
      });
    }
  }

  void onPedestrianStatusError(error) {
    if (mounted) {
      setState(() {
        _status = 'Pedestrian Status not available';
      });
    }
  }

  void onStepCountError(error) {
    setState(() {
      _totalSteps = 0;
    });
  }

  void initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _pedestrianStatusSubscription =
          Pedometer.pedestrianStatusStream.listen((PedestrianStatus event) {
        setState(() {
          _status = event.status.toString();
        });
      }, onError: (error) {
        setState(() {
          _status = 'Pedestrian Status not available';
        });
      });

      _stepCountSubscription =
          Pedometer.stepCountStream.listen((StepCount event) {
        setState(() {
          _totalSteps = event.steps;
        });
      }, onError: (error) {
        setState(() {
          _totalSteps = -1;
        });
      });
    }
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
    _pedestrianStatusSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedometer Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps Taken (Last 24 Hours)',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "$_totalSteps",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian Status',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                _status.toUpperCase(),
                style: _status == 'walking'
                    ? GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600)
                    : GoogleFonts.montserrat(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
