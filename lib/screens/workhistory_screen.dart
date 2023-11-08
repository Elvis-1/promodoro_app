import 'package:flutter/material.dart';
import 'package:promodoro_app/controller/entry_controller.dart';
import 'package:provider/provider.dart';

class WorkHistoryScreen extends StatefulWidget {
  @override
  _WorkHistoryScreenState createState() => _WorkHistoryScreenState();
}

class _WorkHistoryScreenState extends State<WorkHistoryScreen> {
  bool loaded = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!loaded) {
      Provider.of<EntryProviderController>(context).fetchWorkEntries();
      loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Work History'),
        ),
        body: Consumer<EntryProviderController>(
          builder: (context, workEntries, child) {
            return workEntries.entries.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: workEntries.entries.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4, // Add elevation for a card effect
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(
                            'Start Time: ${workEntries.entries[index].startTimestamp}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Stop Time: ${workEntries.entries[index].stopTimestamp}',
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
