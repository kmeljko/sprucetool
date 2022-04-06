import 'package:sprucetool/src/event/model/event.dart';

class RepetitiveEvent extends Event {
  RepetitiveEvent(
      {required id,
      required name,
      required creationTimestamp,
      required lastUpdateTimestamp,
      required DateTime date,
      required String description})
      : super(
            id: id,
            name: name,
            creationTimestamp: creationTimestamp,
            lastUpdateTimestamp: lastUpdateTimestamp,
            date: date,
            description: description);
}
