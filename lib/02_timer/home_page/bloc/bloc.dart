import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/time_record.dart';
part 'state.dart';
part 'event.dart';

/// 秒表状态管理 - 封装业务逻辑
/// 将 业务逻辑 封装到 StopWatchBloc 中后，就可以将 _HomePageState 中的相关代码移除。
/// 让状态类专注于构建逻辑的实现，达到业务逻辑和构建逻辑分离。
///
/// 在界面按键点击时，通过 Bloc 触发事件即可，数据的变化逻辑由 Bloc 派生类进行维护。
/// 如下，在 StopWatchBloc 构造中监听事件，当发送事件时，会触发对应的方法，对状态进行维护。
class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  Ticker? _ticker;
  StopwatchBloc() : super(const StopwatchState()) {
    on<ToggleStopwatchEvent>(_onToggleStopWatch);
    on<RecordStopwatchEvent>(_onRecordStopwatch);
    on<ResetStopwatchEvent>(_resetStopwatch);
    on<_UpdateDurationEvent>(_onUpdateDuration);
  }

  /// 初始化计时器
  void _initTickerWhenNull() {
    if (_ticker != null) return;
    _ticker = Ticker(_onTick);
  }

  /// 销毁计时器
  @override
  Future<void> close() async {
    _ticker?.dispose();
    _ticker = null;
    return super.close();
  }

  Duration _dt = Duration.zero;
  Duration _lastDuration = Duration.zero;

  /// 计时器回调
  void _onTick(Duration elapsed) {
    _dt = elapsed - _lastDuration;
    add(_UpdateDurationEvent(state.duration + _dt));
    _lastDuration = elapsed;
  }

  /// 监听秒表开始、停止事件
  void _onToggleStopWatch(ToggleStopwatchEvent event, Emitter<StopwatchState> emit) {
    _initTickerWhenNull();
    //计时器正在运行
    if (_ticker!.isTicking) {
      _ticker?.stop();
      _lastDuration = Duration.zero;
      emit(state.copyWith(type: StopwatchType.stopped));
    } else {
      _ticker?.start();
      emit(state.copyWith(type: StopwatchType.running));
    }
  }

  /// 监听秒表更新事件
  void _onUpdateDuration(_UpdateDurationEvent event, Emitter<StopwatchState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  /// 监听秒表重置事件
  void _resetStopwatch(ResetStopwatchEvent event, Emitter<StopwatchState> emit) {
    _lastDuration = Duration.zero;
    _dt = Duration.zero;
    emit(const StopwatchState());
  }

  /// 监听秒表记录事件
  void _onRecordStopwatch(RecordStopwatchEvent event, Emitter<StopwatchState> emit) {
    List<TimeRecord> curList = state.durationRecord.map((e) => e).toList();
    Duration current = state.duration;
    Duration addition = state.duration;
    if (curList.isNotEmpty) {
      addition = current - curList.last.record;
    }
    curList.add(TimeRecord(record: current, addition: addition));
    emit(state.copyWith(durationList: curList));
  }
}
