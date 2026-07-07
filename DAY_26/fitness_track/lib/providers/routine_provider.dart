import 'dart:async';

import 'package:flutter/material.dart';
import '../services/workout_routine_service.dart';

class RoutineProvider extends ChangeNotifier {
  RoutineProvider();

  WorkoutRoutine? _currentRoutine;
  int _currentStepIndex = 0;
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;

  WorkoutRoutine? get currentRoutine => _currentRoutine;
  int get currentStepIndex => _currentStepIndex;
  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;

  void startRoutine(WorkoutRoutine routine) {
    _currentRoutine = routine;
    _currentStepIndex = 0;
    _startStepTimer();
    notifyListeners();
  }

  void _startStepTimer() {
    _timer?.cancel();
    if (_currentRoutine == null) return;
    if (_currentRoutine!.steps.isEmpty) return;
    _remainingSeconds =
        _currentRoutine!.steps[_currentStepIndex].durationSeconds;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        t.cancel();
        _isRunning = false;
        notifyListeners();
      }
    });
  }

  void pause() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resume() {
    if (_currentRoutine == null) return;
    if (_remainingSeconds <= 0) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        t.cancel();
        _isRunning = false;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void nextStep() {
    if (_currentRoutine == null) return;
    if (_currentStepIndex < _currentRoutine!.steps.length - 1) {
      _currentStepIndex++;
      _startStepTimer();
    }
  }

  void previousStep() {
    if (_currentRoutine == null) return;
    if (_currentStepIndex > 0) {
      _currentStepIndex--;
      _startStepTimer();
    }
  }

  void stop() {
    _timer?.cancel();
    _currentRoutine = null;
    _currentStepIndex = 0;
    _remainingSeconds = 0;
    _isRunning = false;
    notifyListeners();
  }
}
