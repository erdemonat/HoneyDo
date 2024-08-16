import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';

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
  double _cardHeight = 100.0;
  final List<SubtitleItem> _subtitles = [];
  final TextEditingController _subtitleController = TextEditingController();

  void _handleDoubleTap() {
    setState(() {
      _cardHeight = _cardHeight == 100.0 ? 200.0 : 100.0;
    });
  }

  void _addSubtitle(String subtitleText) {
    setState(() {
      _subtitles.add(SubtitleItem(text: subtitleText));
      _subtitleController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height:
            _cardHeight + (_cardHeight == 200.0 ? (_subtitles.length * 30) : 0),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('%100'),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      widget.tasks,
                      style: cardTitleTextstyle,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (_cardHeight == 200.0) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _subtitles.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _subtitles[index].isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _subtitles[index].isChecked = value ?? false;
                            });
                          },
                          title: Text(_subtitles[index].text),
                        );
                      },
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: false,
                    onChanged: (value) {},
                    title: TextField(
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _addSubtitle(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  )
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width * 1 / 6,
                  //     child: TextField(
                  //       controller: _subtitleController,
                  //       decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         enabledBorder: InputBorder.none,
                  //         disabledBorder: InputBorder.none,
                  //         focusedBorder: InputBorder.none,
                  //         suffixIcon: IconButton(
                  //             onPressed: () {
                  //               final value = _subtitleController.text;
                  //               if (value.isNotEmpty) {
                  //                 _addSubtitle(value);
                  //               }
                  //             },
                  //             icon: const Icon(Icons.add)),
                  //         hintText: 'Ek görev ekle',
                  //       ),
                  //       onSubmitted: (value) {
                  //         if (value.isNotEmpty) {
                  //           _addSubtitle(value);
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ],
            ),
          ),
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
