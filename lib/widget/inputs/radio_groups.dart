part of '../library.dart';

class DynamicRadioGroup<T> extends StatefulWidget {
  const DynamicRadioGroup({
    super.key,
    this.title,
    required this.selectedValue,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.wrapped,
  });

  final String? title;
  final T selectedValue; // The current value (generic)
  final List<T> items; // List of all possible options
  final String Function(T)
  labelBuilder; // Tells the widget what text to show for each item
  final ValueChanged<T?> onChanged; // Callback to update the parent
  final bool? wrapped;

  @override
  State<DynamicRadioGroup<T>> createState() => _DynamicRadioGroupState<T>();
}

class _DynamicRadioGroupState<T> extends State<DynamicRadioGroup<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    var content = widget.items.map((item) {
      return RadioGroup(
        groupValue: _currentValue,
        onChanged: (T? newValue) {
          if (newValue != null) {
            setState(() => _currentValue = newValue);
            widget.onChanged(newValue);
          }
        },
        child: SizedBox(
          width: 150,
          child: RadioListTile<T>.adaptive(
            contentPadding: EdgeInsets.all(0),
            title: Text(widget.labelBuilder(item)),
            value: item,
          ),
        ),
      );
    }).toList();
    return widget.wrapped == true
        ? Wrap(
            children: [
              if (widget.title != null) ...[
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                  child: Wrap(
                    children: [
                      SizedBox(height: 16),
                      Text(widget.title!),
                      Divider(),
                    ],
                  ),
                ),
              ],
              ...content,
              SizedBox(height: 16),
            ],
          )
        : Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null) ...[
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(widget.title!),
                      Divider(),
                    ],
                  ),
                ),
              ],
              ...content,
              SizedBox(height: 16),
            ],
          );
  }
}
/*
return RadioGroup<bool>(
      groupValue: widget.radioValue,
      onChanged: (value) {
        if (value != null) {
          setState(() => val = value);
        }
      },
      child: Column(
        children: [
          RadioListTile<bool>(title: const Text('Has Actions'), value: true),
          RadioListTile<bool>(title: const Text('No Actions'), value: false),
        ],
      ),
    );
*/