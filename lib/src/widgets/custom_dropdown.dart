import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/box_button.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';

class CustomDropDown extends StatefulWidget {
  final String value;
  final Function(String) onClick;
  final List items;
  const CustomDropDown({
    super.key,
    this.value = '',
    required this.onClick,
    this.items = const [],
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isExpanded = false;

  double sizeOfContainer = 48;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BoxButton(
          onClick: () => setState(() {
            isExpanded = !isExpanded;
          }),
          child: EnhancedContainer(
            width: 160,
            height: 48,
            shadow: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.value,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Icon(
                  Icons.arrow_circle_down,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isExpanded,
          child: EnhancedContainer(
            width: 160,
            height: 50.0 * widget.items.length,
            shadow: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (String item in widget.items)
                  Column(
                    children: [
                      BoxButton(
                        onClick: () {
                          widget.onClick(item);
                          setState(() {
                            isExpanded = false;
                          });
                        },
                        child: Container(
                          height: 48.0,
                          alignment: Alignment.center,
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
