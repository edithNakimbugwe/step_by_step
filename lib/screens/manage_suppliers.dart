import 'package:flutter/material.dart';
import 'package:step_by_step/services/api_service.dart';
import 'package:step_by_step/widgets/my_text_widget.dart';

class ManageSuppliers extends StatefulWidget {
  const ManageSuppliers({super.key});

  @override
  State<ManageSuppliers> createState() => _ManageSuppliersState();
}

class _ManageSuppliersState extends State<ManageSuppliers> {
  late Future<List<dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = _getData();
  }

  void _refreshData() {
    setState(() {
      _data = _getData();
    });
  }

  Future<List<dynamic>> _getData() {
    return ApiService.getData('supplier');
  }

  void _deleteRecord(dynamic id) {
    try {
      // Convert id to an integer if it's a string
      int recordId = int.tryParse(id.toString()) ?? id;

      ApiService.deleteData('supplier', recordId).then((_) {
        _refreshData();
      });
    } catch (e) {
      print('Error in _deleteRecord: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: MyTextWidget(
            text: 'My Suppliers',
            colors: Colors.white,
            isHeading: true,
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Supplier Name')),
                          DataColumn(label: Text('Contact')),
                          DataColumn(label: Text('Location')),
                          DataColumn(label: Text('Edit')),
                          DataColumn(label: Text('Delete')),
                        ],
                        rows: snapshot.data!.map<DataRow>((supplier) {
                          final id = supplier['id'];
                          final supplierName =
                              supplier['name'] ?? 'Not provided';
                          final contact = supplier['contact'] ?? 'Not provided';
                          final location =
                              supplier['location'] ?? 'Not provided';

                          return DataRow(
                            cells: [
                              DataCell(Text(supplierName)),
                              DataCell(Text(contact)),
                              DataCell(Text(location)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.purple,
                                  ),
                                  onPressed: () {
                                    print('Edit button tapped');
                                    // _editSales(id);
                                  },
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _deleteRecord(id);
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
