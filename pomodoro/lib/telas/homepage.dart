import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:pomodoro/widgets/button.dart';
import 'package:pomodoro/widgets/progress_icons.dart';
import 'package:pomodoro/model/status_pomodoro.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

const _btnTextStart = "START POMODORO";
const _btnTextResumePomodoro = "RESUME POMODORO";
const _btnTestResumeBreak = "RESUME BREAK";
const _btnTextStartShortBreak = "TAKE SHORT BREAK";
const _btnTextStartLongBreak = "TAKE LONG BREAK";
const _btnTextStartNewSet = "START NEW SET";
const _btnTextPause = "PAUSE";
const _btnTextReset = "RESET";

class _HomeState extends State<Home> {
  static AudioCache player = AudioCache();
  int remaningTime = pomodoroTotalTime;
  String mainBtnText = _btnTextStart;
  // ignore: non_constant_identifier_names
  StatusPomodoro pomodoro_status = StatusPomodoro.pausedPomodoro;
  Timer _timer = new Timer(
      Duration(
        seconds: pomodoroTotalTime,
      ),
      () => {});
  int pomodoroNum = 0;
  int setNum = 0;

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    player.load('bell.mp3');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      //appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Pomodoro number: $pomodoroNum",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              Text(
                "Set: $setNum",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 220.0,
                      lineWidth: 25.0,
                      percent: _getPomodoroPercentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        _secondsToFormatedString(remaningTime),
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      progressColor: statusColor[pomodoro_status],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProgressIcons(
                      total: pomodoroPerSet,
                      done: pomodoroNum - (setNum * pomodoroPerSet),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        statusDescription[pomodoro_status].toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Button(
                      onPress: _mainButtonPressed,
                      text: mainBtnText,
                    ),
                    Button(
                      onPress: _resetButtonPressed,
                      text: _btnTextReset,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _secondsToFormatedString(int seconds) {
    int roundedMin = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMin * 60);
    String remainingSecFormated;

    if (remainingSeconds < 10) {
      remainingSecFormated = "0$remainingSeconds";
    } else {
      remainingSecFormated = remainingSeconds.toString();
    }

    return "$roundedMin:$remainingSecFormated";
  }

  _getPomodoroPercentage() {
    int totalTime;
    switch (pomodoro_status) {
      case StatusPomodoro.runningPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case StatusPomodoro.pausedPomodoro:
        totalTime = pomodoroTotalTime;
        break;
      case StatusPomodoro.runningShortBreak:
        totalTime = shortBreakTime;
        break;
      case StatusPomodoro.pauseShortBreak:
        totalTime = shortBreakTime;
        break;
      case StatusPomodoro.runningLongBreak:
        totalTime = longBreakTime;
        break;
      case StatusPomodoro.pauseLongBreak:
        totalTime = longBreakTime;
        break;
      case StatusPomodoro.setFinished:
        totalTime = pomodoroTotalTime;
        break;
    }

    return (totalTime - remaningTime) / totalTime;
  }

  _mainButtonPressed() {
    switch (pomodoro_status) {
      case StatusPomodoro.pausedPomodoro:
        _startPomodoroCountDown();
        break;
      case StatusPomodoro.runningPomodoro:
        _pausePomodoroCountDown();
        break;
      case StatusPomodoro.runningShortBreak:
        _pauseShortBreakCountDown();
        break;
      case StatusPomodoro.pauseShortBreak:
        _startShorBreak();
        break;
      case StatusPomodoro.runningLongBreak:
        _pauseLongBreakCountDown();
        break;
      case StatusPomodoro.pauseLongBreak:
        _startLongBreak();
        break;
      case StatusPomodoro.setFinished:
        setNum++;
        _startPomodoroCountDown();
        break;
      default:
    }
  }

  _startPomodoroCountDown() {
    pomodoro_status = StatusPomodoro.runningPomodoro;
    _cancelTimer();
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              if (remaningTime > 0)
                {
                  setState(() {
                    remaningTime--;
                    mainBtnText = _btnTextPause;
                  })
                }
              else
                {
                  _playSound(),
                  pomodoroNum++,
                  _cancelTimer(),
                  if (pomodoroNum % pomodoroPerSet == 0)
                    {
                      pomodoro_status = StatusPomodoro.pauseLongBreak,
                      setState(() {
                        remaningTime = longBreakTime;
                        mainBtnText = _btnTextStartLongBreak;
                      }),
                    }
                  else
                    {
                      pomodoro_status = StatusPomodoro.pauseShortBreak,
                      setState(() {
                        remaningTime = shortBreakTime;
                        mainBtnText = _btnTextStartShortBreak;
                      }),
                    }
                }
            });
  }

  _startShorBreak() {
    pomodoro_status = StatusPomodoro.runningShortBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => {
        if (remaningTime > 0)
          {
            setState(() {
              remaningTime--;
            }),
          }
        else
          {
            _playSound(),
            remaningTime = pomodoroTotalTime,
            _cancelTimer(),
            pomodoro_status = StatusPomodoro.pausedPomodoro,
            setState(() {
              mainBtnText = _btnTextStart;
            }),
          },
      },
    );
  }

  _startLongBreak() {
    pomodoro_status = StatusPomodoro.runningLongBreak;
    setState(() {
      mainBtnText = _btnTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => {
        if (remaningTime > 0)
          {
            setState(() {
              remaningTime--;
            }),
          }
        else
          {
            _playSound(),
            remaningTime = pomodoroTotalTime,
            _cancelTimer(),
            pomodoro_status = StatusPomodoro.setFinished,
            setState(() {
              mainBtnText = _btnTextStartNewSet;
            }),
          },
      },
    );
  }

  _pausePomodoroCountDown() {
    pomodoro_status = StatusPomodoro.pausedPomodoro;
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumePomodoro;
    });
  }

  _resetButtonPressed() {
    pomodoroNum = 0;
    setNum = 0;
    _cancelTimer();
    _stopCountDown();
  }

  _stopCountDown() {
    pomodoro_status = StatusPomodoro.pausedPomodoro;
    setState(() {
      mainBtnText = _btnTextStart;
      remaningTime = pomodoroTotalTime;
    });
  }

  _pauseShortBreakCountDown() {
    pomodoro_status = StatusPomodoro.pauseShortBreak;
    _pauseBreakCoundDown();
  }

  _pauseLongBreakCountDown() {
    pomodoro_status = StatusPomodoro.pauseLongBreak;
    _pauseBreakCoundDown();
  }

  _pauseBreakCoundDown() {
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTestResumeBreak;
    });
  }

  _cancelTimer() {
    // ignore: unnecessary_null_comparison
    if (_timer != null) {
      _timer.cancel();
    }
  }

  _playSound() {
    player.play('bell.mp3');
  }
}
