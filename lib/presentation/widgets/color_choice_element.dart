import 'package:flutter/cupertino.dart';
import 'package:taskassistant/constants/colors.dart';

class ColorChooser extends StatefulWidget {
  const ColorChooser({
    Key? key,
    required this.colors,
    required this.onColorSelected,
    required this.index,
  }) : super(key: key);

  final List<Color> colors;
  final Function(Color) onColorSelected;
  final int index;

  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.colors.isNotEmpty ? widget.colors[widget.index] : null;
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
    widget.onColorSelected(color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.colors.map((color) {
        return GestureDetector(
          onTap: () => _selectColor(color),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: _selectedColor == color ? Border.all(color: AppColors.black, width: 3) : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
