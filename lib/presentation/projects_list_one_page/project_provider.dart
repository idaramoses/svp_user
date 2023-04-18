
import 'package:flutter/cupertino.dart';

import '../../models/event.dart';

class ProjectProvider extends ChangeNotifier {
  List<Event> _allEvents;

  //getter
  List<Event> get allEvents => _allEvents;


  //setter
  set allEvents(List<dynamic> data) {
    if (data != null) {
      List<Event> _data = [];

      data.forEach((element) {
        _data.add(
          Event.fromJson(
            Map<String, dynamic>.from(element),
          ),
        );
      });

      _allEvents = _data;
      notifyListeners();
    }
  }

}
