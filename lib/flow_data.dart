import 'package:cloud_firestore/cloud_firestore.dart';

class FlowData {
  final DateTime date_time;
  final int count;
  final List<String> flowy;

  FlowData(this.date_time, this.count, this.flowy);
}

// Produce a list of flow data for the user (aggregated sums per day)
List<FlowData> produceListOfFlowData(var results){
  // We only care about the first user
  var userInfo = results[0];
  List<dynamic> buttonPresses = userInfo!['button_log'] ?? [];

  Map<DateTime, int> my_dates = {};
  Set<DateTime> the_dates = {};
  for(int j = 0; j < buttonPresses.length; j++){
    Timestamp timeStamp = buttonPresses[j];

    // We need to convert our seconds to a DateTime object
    DateTime my_date = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);

    // Truncate the date to exclude time specifics
    DateTime truncated_date = new DateTime(my_date.year, my_date.month, my_date.day, 0,0,0,0,0);

    // If we already have the entry, add to it otherwise create a new one
    if(my_dates[truncated_date] == null){
      my_dates[truncated_date] = 1;
    }
    else{
      int cur_date = my_dates[truncated_date] ?? 0;
      my_dates[truncated_date] = cur_date + 1;
    }

    the_dates.add(truncated_date);
  }

  List<DateTime> another_date_list = the_dates.toList();
  another_date_list.sort();

  List<FlowData> flow_series_data = [];
  for(int k = 0; k < another_date_list.length; k++){
    DateTime key = another_date_list[k];
    int value = my_dates[key] ?? 0;

    List<String> flowy_bois = [];
    for(int q = 0; q < value; q++){
      flowy_bois.add('tampon');
    }

    flow_series_data.add(FlowData(key, value, flowy_bois));
  }

  return flow_series_data;
}