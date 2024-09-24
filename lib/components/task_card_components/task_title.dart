import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:provider/provider.dart';

class TaskTitle extends StatefulWidget {
  final Task task;
  final VoidCallback onPressed;
  final Function(bool) onTaskChecked;

  const TaskTitle({
    super.key,
    required this.task,
    required this.onPressed,
    required this.onTaskChecked,
  });

  @override
  TaskTitleState createState() => TaskTitleState();
}

class TaskTitleState extends State<TaskTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.task.isChecked,
          onChanged: (value) {
            if (value != null) {
              widget.onTaskChecked(value);
            }
          },
          activeColor: Theme.of(context).colorScheme.surface,
          checkColor: Theme.of(context).colorScheme.tertiary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: widget.onPressed,
              child: GestureDetector(
                onSecondaryTapDown: (details) {
                  _showColorOverlay(details.globalPosition);
                },
                child: Text(
                  textScaler: MediaQuery.textScalerOf(context),
                  widget.task.name,
                  style: widget.task.isMarked
                      ? TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 24,
                          decorationColor: Color(
                            int.parse(widget.task.markColor),
                          ).withOpacity(0.25),
                        )
                      : kCardTitleTextStyle(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showColorOverlay(Offset position) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedOverlay(
        position: position,
        onClose: () {
          overlayEntry.remove();
        },
        onColorSelected: (color) {
          setState(() {
            widget.task.markColor = color.value.toString();
            widget.task.isMarked = true;
          });

          Provider.of<TasksMealsProvider>(context, listen: false).updateTaskMarkStatus(widget.task, color.value.toString(), true);

          overlayEntry.remove();
        },
        onClear: () async {
          await Provider.of<TasksMealsProvider>(context, listen: false).updateTaskMarkStatus(widget.task, "", false);
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _AnimatedOverlay extends StatefulWidget {
  final Offset position;
  final VoidCallback onClose;
  final Function(Color) onColorSelected;
  final VoidCallback onClear;

  const _AnimatedOverlay({
    required this.position,
    required this.onClose,
    required this.onColorSelected,
    required this.onClear,
  });

  @override
  __AnimatedOverlayState createState() => __AnimatedOverlayState();
}

class __AnimatedOverlayState extends State<_AnimatedOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Color? _hoveredColor;
  double hoveredRadius = 16;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onClose,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          left: widget.position.dx,
          top: widget.position.dy,
          child: FadeTransition(
            opacity: _animation,
            child: ScaleTransition(
              scale: _animation,
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.transparent,
                child: _buildOverlayMenu(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverlayMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              _buildColorBox(context, Colors.red),
              _buildColorBox(context, Colors.purple),
              _buildColorBox(context, Colors.green),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              _buildColorBox(context, Colors.yellow),
              _buildColorBox(context, Colors.orange),
              _buildClearIcon(context, Colors.transparent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(BuildContext context, Color color) {
    return InkWell(
      onTap: () {
        widget.onColorSelected(color);
      },
      onHover: (isHovering) {
        setState(() {
          _hoveredColor = isHovering ? color : null;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Theme.of(context).colorScheme.tertiary),
          color: color,
          borderRadius: BorderRadius.circular(_hoveredColor == color ? 6 : 16),
        ),
        width: 30,
        height: 30,
      ),
    );
  }

  Widget _buildClearIcon(BuildContext context, Color color) {
    return InkWell(
      onTap: widget.onClear,
      onHover: (isHovering) {
        setState(() {
          _hoveredColor = isHovering ? color : null;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Theme.of(context).colorScheme.tertiary),
          color: color,
          borderRadius: BorderRadius.circular(_hoveredColor == color ? 6 : 16),
        ),
        width: 30,
        height: 30,
        child: Icon(
          Icons.block,
          color: Theme.of(context).colorScheme.tertiary,
          size: 18,
        ),
      ),
    );
  }
}
