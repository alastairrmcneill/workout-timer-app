import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';

class WorkoutBottomSheet extends StatelessWidget {
  const WorkoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DraggableScrollableController _dragableScrollController = DraggableScrollableController();
    ActivityNotifier activityNotifiter = Provider.of<ActivityNotifier>(context);
    TimerNotifier timerNotifier = Provider.of<TimerNotifier>(context);
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
          child: ListView.builder(
            controller: scrollController,
            itemCount: activityNotifiter.activityList!.length,
            itemBuilder: (context, index) {
              Activity activity = activityNotifiter.activityList![index];
              return ListTile(
                title: Text(activity.name),
                subtitle: timerNotifier.currentStageIndex != null
                    ? index < timerNotifier.currentStageIndex! - 1
                        ? Text('Done')
                        : Text('Active')
                    : Text('Active'),
              );
            },
          ),
        );
      }),
    );
  }
}
