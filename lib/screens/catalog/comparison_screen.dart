
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = ControllerScope.of(context).catalog;
    final vehicles = catalog.compareList;
    return Scaffold(
      appBar: AppBar(title: const Text('Compare vehicles')),
      body: vehicles.length < 2
          ? const Center(child: Text('Select at least two vehicles.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Metric')),
                  DataColumn(label: Text('Option 1')),
                  DataColumn(label: Text('Option 2')),
                  DataColumn(label: Text('Option 3')),
                ],
                rows: [
                  _row('Seats', vehicles.map((e) => e.seats.toString()).toList()),
                  _row('Power', vehicles.map((e) => e.power).toList()),
                  _row('Range', vehicles.map((e) => '${e.rangeKm}').toList()),
                  _row('Price', vehicles.map((e) => '${e.basePrice}').toList()),
                ],
              ),
            ),
    );
  }

  DataRow _row(String metric, List<String> values) {
    final cells = <DataCell>[DataCell(Text(metric))];
    for (var i = 0; i < 3; i++) {
      cells.add(DataCell(Text(i < values.length ? values[i] : '-')));
    }
    return DataRow(cells: cells);
  }
}
