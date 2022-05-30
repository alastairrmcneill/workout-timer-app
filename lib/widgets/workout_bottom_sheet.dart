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
    ActivityNotifier activityNotifiter = Provider.of<ActivityNotifier>(context);

    bool atTop = false;

    return DraggableScrollableSheet(
      // controller: _dragableScrollController,
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
              // IconButton(
              //     onPressed: () {
              //       _dragableScrollController
              //           .animateTo(atTop ? 0.1 : 0.7,
              //               duration: const Duration(
              //                 milliseconds: 200,
              //               ),
              //               curve: Curves.linear)
              //           .whenComplete(() {
              //         atTop = !atTop;
              //       });
              //     },
              //     icon: atTop ? const Icon(Icons.keyboard_double_arrow_down_rounded) : const Icon(Icons.keyboard_double_arrow_up_rounded)),
              ...activityNotifiter.activityList!.map((activity) {
                return ListTile(
                  title: Text('${activity.name}'),
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
