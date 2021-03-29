import 'package:twitch_api/src/models/twitch_time_period.dart';

extension TwitchTimePeriodModifier on TwitchTimePeriod {
  String get string => this.toString().split('.').last;
}
