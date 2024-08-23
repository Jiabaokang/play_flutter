part of 'bloc.dart';

enum StopwatchType {
  none, //初始状态
  stopped, //停止
  running //运行
}

/// 使用 bloc 封装业务逻辑 - 状态类-定义需要修改的数据
class StopwatchState {
  /// 秒表状态
  final StopwatchType type;

  /// 秒表记录
  final List<TimeRecord> durationRecord;

  /// 秒表运行的时长
  final Duration duration;

  Duration get secondDuration {
    if (durationRecord.isNotEmpty) {
      return duration - durationRecord.last.record;
    }
    return duration;
  }

  const StopwatchState({
    this.type = StopwatchType.none,
    this.durationRecord = const [],
    this.duration = Duration.zero,
  });

  StopwatchState copyWith({
    StopwatchType? type,
    List<TimeRecord>? durationList,
    Duration? duration,
  }) {
    return StopwatchState(
      type: type ?? this.type,
      durationRecord: durationList ?? durationRecord,
      duration: duration ?? this.duration,
    );
  }
}
