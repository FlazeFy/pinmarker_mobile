import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/general/converter.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/dictionary/model/queries.dart';
import 'package:pinmarker/services/modules/dictionary/service/queries.dart';

class GetAllDctByType extends StatefulWidget {
  const GetAllDctByType(
      {super.key, required this.type, this.action, required this.selected});
  final String type;
  final String selected;
  final dynamic action;

  @override
  StateGetAllDctByType createState() => StateGetAllDctByType();
}

class StateGetAllDctByType extends State<GetAllDctByType> {
  late DictionaryQueriesService apiHistoryQuery;
  int i = 0;
  List<DctModel> dt = [];
  bool isLoading = true;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    apiHistoryQuery = DictionaryQueriesService();
    selectedValue = widget.selected;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      dt = await apiHistoryQuery.getDctByType(widget.type);
      dt.add(DctModel(dctName: '-'));
      if (!dt.any((element) => element.dctName == selectedValue)) {
        selectedValue = null;
      }
    } catch (e) {
      // print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    return SafeArea(
      maintainBottomViewPadding: false,
      child: _buildListView(dt),
    );
  }

  Widget _buildListView(List<DctModel> data) {
    if (data.isNotEmpty) {
      return DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: spaceMD),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(roundedMD),
              borderSide: const BorderSide(color: primaryColor)),
        ),
        hint: Text(
          'Select Total Type',
          style: TextStyle(fontSize: textMD, color: primaryColor),
        ),
        value: selectedValue,
        items: data
            .map((item) => DropdownMenuItem<String>(
                  value: item.dctName,
                  child: Text(
                    ucAll(item.dctName),
                    style: TextStyle(fontSize: textMD, color: primaryColor),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select total type';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          widget.action(value);
        },
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.arrow_drop_down,
            color: primaryColor,
          ),
          iconSize: textJumbo,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(roundedLG),
              border: Border.all(color: primaryColor, width: 1)),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: spaceMD),
        ),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
