import 'package:sprucetool/src/event/model/event.dart';

class OneTimeEvent extends Event {
  
  OneTimeEvent(
      {required id,
      required name,
      required creationTimestamp,
      required lastUpdateTimestamp,
      required DateTime date,
      required bool done,
      required String description})
      : super(
            id: id,
            name: name,
            creationTimestamp: creationTimestamp,
            lastUpdateTimestamp: lastUpdateTimestamp,
            date: date,
            description: description);
}
