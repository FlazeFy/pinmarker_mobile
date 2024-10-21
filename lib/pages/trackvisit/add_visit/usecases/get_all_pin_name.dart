import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/pin/queries.dart';

class GetAllPinName extends StatefulWidget {
  const GetAllPinName({super.key, this.action, required this.selected});
  final String selected;
  final dynamic action;

  @override
  StateGetAllPinName createState() => StateGetAllPinName();
}

class StateGetAllPinName extends State<GetAllPinName> {
  late QueriesPinServices apiPinQuery;
  int i = 0;
  List<PinNameModel> dt = [];
  bool isLoading = true;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    apiPinQuery = QueriesPinServices();
    selectedValue = widget.selected;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      dt = await apiPinQuery.getAllPinName();
      dt.add(PinNameModel(id: '-', pinName: '-'));
      if (!dt.any((element) => element.id == selectedValue)) {
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

  Widget _buildListView(List<PinNameModel> data) {
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
          'Select Pin Name',
          style: TextStyle(fontSize: textMD, color: primaryColor),
        ),
        value: selectedValue,
        items: data
            .map((item) => DropdownMenuItem<String>(
                  value: item.id,
                  child: Text(
                    item.pinName,
                    style: TextStyle(fontSize: textMD, color: primaryColor),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select pin name';
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
