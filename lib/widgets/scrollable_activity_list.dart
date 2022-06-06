import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_timer_app/models/models.dart';
import 'package:workout_timer_app/notifiers/notifiers.dart';
import 'package:workout_timer_app/services/services.dart';

class ScrollableActivityList extends StatefulWidget {
  final MultiStageTimer timer;
  const ScrollableActivityList({Key? key, required this.timer}) : super(key: key);

  @override
  State<ScrollableActivityList> createState() => _ScrollableActivityListState();
}

class _ScrollableActivityListState extends State<ScrollableActivityList> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ActivityNotifier activityNotifier = Provider.of<ActivityNotifier>(context);
    TimerNotifier timerNotifier = Provider.of<TimerNotifier>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 190,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        physics: ClampingScrollPhysics(),
        controller: _scrollController,
        itemCount: activityNotifier.activityList!.length,
        itemBuilder: (context, index) {
          Activity activity = activityNotifier.activityList![index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                (index >= timerNotifier.currentStageIndex! - 1 && !widget.timer.isFinished) ? Colors.transparent : Colors.grey.withOpacity(0.8),
                BlendMode.saturation,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          activity.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          '${activity.time}s',
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 13, color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        widget.timer.skipToStage(index + 1);
                      },
                      icon: Icon(
                        (index >= timerNotifier.currentStageIndex!) ? Icons.skip_next : Icons.restart_alt,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
