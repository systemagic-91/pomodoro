import 'package:flutter/material.dart';
import 'package:pomodoro/model/status_pomodoro.dart';

const pomodoroTotalTime = 50 * 60;
const shortBreakTime = 10 * 60;
const longBreakTime = 25 * 60;
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
  StatusPomodoro.runningPomodoro: Colors.green,
  StatusPomodoro.pausedPomodoro: Colors.orange,
  StatusPomodoro.runningShortBreak: Colors.red,
  StatusPomodoro.pauseShortBreak: Colors.orange,
  StatusPomodoro.runningLongBreak: Colors.red,
  StatusPomodoro.pauseLongBreak: Colors.orange,
  StatusPomodoro.setFinished: Colors.orange
};
