part of 'bloc.dart';

/// 使用 bloc 封装业务逻辑 - 事件类-需要触发的事件
abstract class StopwatchEvent {
  const StopwatchEvent();
}

class ResetStopwatchEvent extends StopwatchEvent {
  const ResetStopwatchEvent();
}

class ToggleStopwatchEvent extends StopwatchEvent {
  const ToggleStopwatchEvent();
}

class RecordStopwatchEvent extends StopwatchEvent {
  const RecordStopwatchEvent();
}

class _UpdateDurationEvent extends StopwatchEvent {
  final Duration duration;
  const _UpdateDurationEvent(this.duration);
}
