import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyTaskCard extends StatefulWidget {
  const MyTaskCard({
    super.key,
    required this.tasks,
  });

  final String tasks;

  @override
  MyTaskCardState createState() => MyTaskCardState();
}

class MyTaskCardState extends State<MyTaskCard> {
  static const double _collapsedHeight = 100.0;
  static const double _expandedBaseHeight = 200.0;
  static const double _subtitleHeightIncrement = 30.0;
  late Task task;

  double _cardHeight = _collapsedHeight;
  double _currentExpandedHeight = _expandedBaseHeight;
  final List<SubtitleItem> _subtitles = [];
  final TextEditingController _subtitleController = TextEditingController();

  void _toggleCardHeight() {
    setState(() {
      if (_cardHeight == _collapsedHeight) {
        _cardHeight = _currentExpandedHeight;
      } else {
        _cardHeight = _collapsedHeight;
      }
    });
  }

  Future<void> _loadSubTaks() async {
    await task.subtasks.load();
  }

  Future<void> _addSubtitle(String subtitleText) async {
    final subTask = SubTask()
      ..name = subtitleText
      ..isChecked = false;
    await isar.writeTxn(
      () async {
        await isar.subTasks.put(subTask);
        task.subtasks.value = subTask;
        await task.subtasks.save();
      },
    );
    setState(() {
      _subtitleController.clear();
      _currentExpandedHeight += _subtitleHeightIncrement;
      if (_cardHeight > _collapsedHeight) {
        _cardHeight += _subtitleHeightIncrement;
      }
    });
  }

  void _deleteSubtitle(String subtitleText, int index) {
    setState(() {
      _subtitles.remove(_subtitles[index]);
      _currentExpandedHeight -= _subtitleHeightIncrement;
      if (_cardHeight > _collapsedHeight) {
        _cardHeight -= _subtitleHeightIncrement;
      }
    });
  }

  void _updateSubtitleCheckStatus(int index, bool? value) {
    setState(() {
      _subtitles[index].isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _cardHeight,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              if (_cardHeight == _collapsedHeight) Text('%100'),
              if (_cardHeight > _collapsedHeight) _buildTextLabels(context, 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 10),
                    if (_cardHeight > _collapsedHeight) _buildExpandedContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextLabels(BuildContext context, int subTaskLength) {
    final Brightness brightness = Theme.of(context).brightness;
    double perTaskPercentage = 100 / subTaskLength;
    const double deliveryStatus = 20;
    const double orderState = 0;
    const double packedState = 10;
    const double shippedState = 20;
    const double deliveredState = 30;
    const Color activeColor =
        deliveryStatus > orderState ? Color(0xff0DC9AB) : Color(0xffD1D9DD);
    final Color inactiveColor = brightness == Brightness.dark
        ? const Color(0xff62686A)
        : const Color(0xFFD1D9DD);

    return SizedBox(
        height: 300,
        child: SfLinearGauge(
          orientation: LinearGaugeOrientation.vertical,
          maximum: 30,
          showLabels: false,
          showTicks: false,
          axisTrackStyle: LinearAxisTrackStyle(
            color: inactiveColor,
          ),
          barPointers: const <LinearBarPointer>[
            LinearBarPointer(
              value: deliveryStatus,
              color: activeColor,
              enableAnimation: false,
            ),
          ],
          markerPointers: <LinearMarkerPointer>[
            LinearWidgetPointer(
              value: orderState,
              enableAnimation: false,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(width: 4, color: activeColor),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: const Center(
                  child:
                      Icon(Icons.check_rounded, size: 14, color: activeColor),
                ),
              ),
            ),
            LinearWidgetPointer(
              enableAnimation: false,
              value: packedState,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(width: 4, color: activeColor),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: const Center(
                  child:
                      Icon(Icons.check_rounded, size: 14, color: activeColor),
                ),
              ),
            ),
            LinearWidgetPointer(
              value: shippedState,
              enableAnimation: false,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(width: 4, color: activeColor),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: const Center(
                  child:
                      Icon(Icons.check_rounded, size: 14, color: activeColor),
                ),
              ),
            ),
            LinearShapePointer(
              value: deliveredState,
              enableAnimation: false,
              color: inactiveColor,
              width: 24,
              height: 24,
              position: LinearElementPosition.cross,
              shapeType: LinearShapePointerType.circle,
            ),
          ],
        ));
  }

  Widget _buildHeader() {
    return TextButton(
      child: Text(
        widget.tasks,
        style: cardTitleTextstyle,
      ),
      onPressed: _toggleCardHeight,
    );
  }

  Widget _buildExpandedContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSubtitleList(),
            _buildSubtitleInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitleList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _subtitles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            _deleteSubtitle(_subtitles[index].text, index);
          },
          child: CheckboxListTile(
            checkboxShape: const CircleBorder(),
            side: BorderSide(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
              width: 2,
              strokeAlign: 2,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: _subtitles[index].isChecked,
            onChanged: (value) => _updateSubtitleCheckStatus(index, value),
            title: Text(_subtitles[index].text),
          ),
        );
      },
    );
  }

  Widget _buildSubtitleInput() {
    return CheckboxListTile(
      checkboxShape: const CircleBorder(),
      side: BorderSide(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
        width: 2,
        strokeAlign: 2,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: false,
      onChanged: (value) {},
      title: TextField(
        controller: _subtitleController,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            _addSubtitle(value);
          }
        },
        decoration: InputDecoration(
          hintText: 'Bir görev ekle...',
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SubtitleItem {
  SubtitleItem({required this.text, this.isChecked = false});

  String text;
  bool isChecked;
}
