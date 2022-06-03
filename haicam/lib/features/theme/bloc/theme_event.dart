part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  final ThemeData theme;
  const ThemeEvent({required this.theme});

  @override
  List<Object> get props => [theme];
}
