import 'package:flutter/cupertino.dart';
import 'package:taskassistant/constants/colors.dart';
import 'package:taskassistant/constants/extensions.dart';

class CupertinoDatePickerWidget extends StatefulWidget {
  final DateTime initialDate;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final Function(DateTime) onDateSelected;

  const CupertinoDatePickerWidget({
    Key? key,
    required this.initialDate,
    required this.minimumDate,
    required this.maximumDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CupertinoDatePickerWidgetState createState() => _CupertinoDatePickerWidgetState();
}

class _CupertinoDatePickerWidgetState extends State<CupertinoDatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: AppColors.primaryWhite,
          child: Column(
            children: [
              // Done button at the top
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: const Text("Done"),
                      onPressed: () {
                        widget.onDateSelected(_selectedDate);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: widget.initialDate,
                  minimumDate: widget.minimumDate,
                  maximumDate: widget.maximumDate,
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Deadline",
          style: context.bodyPlaceholder.copyWith(fontSize: 12),
        ),
        GestureDetector(
          onTap: () => _showDatePicker(context),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: AppColors.black.withOpacity(0.3),
                )),
            padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Text(
              "Select Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}",
              style: context.body,
            ),
          ),
        ),
      ],
    );
  }
}
