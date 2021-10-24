import 'package:flutter/material.dart';
import 'package:pomodoro/model/status_pomodoro.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 10 * 60;
const pomodoroPerSet = 4;

const Map<StatusPomodoro, String> statusDescription = {
  StatusPomodoro.runningPomodoro: 'Time to focus!',
  StatusPomodoro.pausedPomodoro: 'Ready for a focus?',
  StatusPomodoro.runningShortBreak: 'Time for a short break',
  StatusPomodoro.pauseShortBreak: 'Let\'s have a short break ?',
  StatusPomodoro.runningLongBreak: 'Time for a long break',
  StatusPomodoro.pauseLongBreak: 'Let\'s have a long break?',
  StatusPomodoro.setFinished: 'Congrats, you deserve a long break!',
};

const Map<StatusPomodoro, MaterialColor> statusColor = {
  StatusPomodoro.runningPomodoro: Colors.purple,
  StatusPomodoro.pausedPomodoro: Colors.red,
  StatusPomodoro.runningShortBreak: Colors.yellow,
  StatusPomodoro.pauseShortBreak: Colors.red,
  StatusPomodoro.runningLongBreak: Colors.yellow,
  StatusPomodoro.pauseLongBreak: Colors.red,
  StatusPomodoro.setFinished: Colors.orange
};
