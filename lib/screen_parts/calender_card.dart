import 'package:flutter/material.dart';
import 'package:honeydo/components/day_bubble.dart';

class CalenderCard extends StatelessWidget {
  const CalenderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Mart 2024"),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.date_range_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DayBubble(),
                DayBubble(),
                DayBubble(),
                DayBubble(),
                DayBubble(),
                DayBubble(),
                DayBubble(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
