import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ListViewItems extends StatelessWidget {
  final IconData icon;
  ListViewItems({@required this.icon});

  @override
  Widget build(BuildContext context) {
    final scanList = Provider.of<ScanListProvider>(context);

    return ListView.builder(
        itemCount: scanList.scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (DismissDirection direction) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteById(scanList.scans[i].id);
              },
              child: ListTile(
                leading: Icon(icon, color: Theme.of(context).primaryColor),
                title: Text(scanList.scans[i].valor),
                trailing: Icon(Icons.keyboard_arrow_left, color: Colors.grey),
                onTap: () => launchURL(context, scanList.scans[i]),
              ),
            ));
  }
}
