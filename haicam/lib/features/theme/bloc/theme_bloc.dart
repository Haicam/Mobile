import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prac_haicam/features/theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: AppTheme.lightTheme)) {
    on<ThemeEvent>((event, emit) {
      if (event is ThemeEvent) {
        emit(ThemeState(theme: event.theme));
      }
    });
  }
}
