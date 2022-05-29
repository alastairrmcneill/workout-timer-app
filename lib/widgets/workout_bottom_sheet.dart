import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class WorkoutBottomSheet extends StatelessWidget {
  const WorkoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DraggableScrollableController _dragableScrollController = DraggableScrollableController();
    bool atTop = false;
    ActivityNotifiter activityNotifiter = Provider.of<ActivityNotifiter>(context);

    return DraggableScrollableSheet(
      controller: _dragableScrollController,
      snap: true,
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.7,
      builder: ((context, scrollController) {
        return Container(
          color: Colors.blue,
          child: ListView(
            controller: scrollController,
            children: [
              IconButton(
                  onPressed: () {
                    _dragableScrollController
                        .animateTo(0.7,
                            duration: Duration(
                              milliseconds: 200,
                            ),
                            curve: Curves.linear)
                        .whenComplete(() {
                      atTop = true;
                    });
                  },
                  icon: atTop ? Icon(Icons.arrow_downward) : Icon(Icons.arrow_upward)),
              ...activityNotifiter.activityList!.map((activity) {
                return ListTile(
                  title: const Text('activity.name'),
                  subtitle: Text('${activity.time}s'),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }),
    );
  }
}
