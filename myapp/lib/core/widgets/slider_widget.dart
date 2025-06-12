import 'package:calcvio/core/utils/Appcolors.dart';
import 'package:flutter/material.dart';

class SliderforAmount extends StatefulWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Function(double) onChanged;
  final String suffix;

  const SliderforAmount({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.suffix,
  });

  @override
  State<SliderforAmount> createState() => _SliderforAmountState();
}

class _SliderforAmountState extends State<SliderforAmount> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isUserEditing = false;
  late double _defaultValue;

  @override
  void initState() {
    super.initState();
    _defaultValue = widget.value;
    _controller = TextEditingController(text: _defaultValue.toStringAsFixed(0));

    _controller.addListener(() {
      if (!_isUserEditing) return;

      final text = _controller.text;

      final parsed = double.tryParse(text);
      if (parsed == null || parsed < widget.min || parsed > widget.max) {
        setState(() {
          _errorText = 'Enter ${widget.min.toInt()}-${widget.max.toInt()}';
        });
      } else {
        if (_errorText != null) {
          setState(() => _errorText = null);
        }
        widget.onChanged(parsed);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SliderforAmount oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.value.toStringAsFixed(0);
    if (!_isUserEditing && _controller.text != newText) {
      setState(() {
        _controller.text = newText;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 110,
              child: Focus(
                onFocusChange: (hasFocus) {
                  _isUserEditing = hasFocus;
                  if (!hasFocus && _controller.text.trim().isEmpty) {
                    final defaultText = _defaultValue.toStringAsFixed(0);
                    setState(() {
                      _controller.text = defaultText;
                      _controller.selection = TextSelection.collapsed(
                        offset: defaultText.length,
                      );
                      _errorText = null; // Clear the error
                    });
                    widget.onChanged(_defaultValue);
                  }
                },

                child: TextField(
                  enableInteractiveSelection: false,

                  cursorColor: AppColors.lightChartLine,
                  style: TextStyle(
                    color: AppColors.lightChartLine,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.end,
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightSliderInactive,
                    prefixText: '₹',
                    prefixStyle: TextStyle(color: AppColors.lightChartLine),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorText: _errorText,
                    errorStyle: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      SliderTickMarkShape.noTickMark, // Hides tick marks
                ),
                child: Slider(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  activeColor: AppColors.lightChartLine,
                  inactiveColor: AppColors.lightSliderInactive,

                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  onChanged: (val) {
                    widget.onChanged(val);

                    _controller.text = val.toStringAsFixed(0);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SliderForYears extends StatefulWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Function(double) onChanged;
  final String suffix;

  const SliderForYears({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.suffix,
  });

  @override
  State<SliderForYears> createState() => _SliderForYearsState();
}

class _SliderForYearsState extends State<SliderForYears> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isUserEditing = false;
  late double _defaultValue;

  @override
  void initState() {
    super.initState();
    _defaultValue = widget.value;
    _controller = TextEditingController(text: _defaultValue.toStringAsFixed(0));

    _controller.addListener(() {
      if (!_isUserEditing) return;

      final text = _controller.text;
      final parsed = double.tryParse(text);

      if (parsed == null || parsed < widget.min || parsed > widget.max) {
        setState(() {
          _errorText = 'Enter ${widget.min.toInt()} - ${widget.max.toInt()}';
        });
      } else {
        if (_errorText != null) {
          setState(() => _errorText = null);
        }
        widget.onChanged(parsed);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SliderForYears oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.value.toStringAsFixed(0);
    if (!_isUserEditing && _controller.text != newText) {
      _controller.text = newText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 110,
              child: Focus(
                onFocusChange: (hasFocus) {
                  _isUserEditing = hasFocus;
                  if (!hasFocus && _controller.text.trim().isEmpty) {
                    final defaultText = _defaultValue.toStringAsFixed(0);
                    setState(() {
                      _controller.text = defaultText;
                      _controller.selection = TextSelection.collapsed(
                        offset: defaultText.length,
                      );
                      _errorText = null; // Clear the error
                    });
                    widget.onChanged(_defaultValue);
                  }
                },
                child: TextField(
                  enableInteractiveSelection: false,
                  cursorColor: AppColors.lightChartLine,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.lightChartLine,
                    fontSize: 14,
                  ),
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightSliderInactive,
                    suffixText: 'yrs',
                    suffixStyle: TextStyle(color: AppColors.lightChartLine),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorText: _errorText,
                    errorStyle: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      SliderTickMarkShape.noTickMark, // Hides tick marks
                ),
                child: Slider(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  activeColor: AppColors.lightChartLine,
                  inactiveColor: AppColors.lightSliderInactive,
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  onChanged: (val) {
                    widget.onChanged(val);
                    _controller.text = val.toStringAsFixed(0);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SliderForMonth extends StatefulWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Function(double) onChanged;
  final String suffix;

  const SliderForMonth({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.suffix,
  });

  @override
  State<SliderForMonth> createState() => _SliderForMonthState();
}

class _SliderForMonthState extends State<SliderForMonth> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isUserEditing = false;
  late double _defaultValue;

  @override
  void initState() {
    super.initState();
    _defaultValue = widget.value;
    _controller = TextEditingController(text: _defaultValue.toStringAsFixed(0));

    _controller.addListener(() {
      if (!_isUserEditing) return;

      final text = _controller.text;
      final parsed = double.tryParse(text);

      if (parsed == null || parsed < widget.min || parsed > widget.max) {
        setState(() {
          _errorText = 'Enter ${widget.min.toInt()} - ${widget.max.toInt()}';
        });
      } else {
        if (_errorText != null) {
          setState(() => _errorText = null);
        }
        widget.onChanged(parsed);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SliderForMonth oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.value.toStringAsFixed(0);
    if (!_isUserEditing && _controller.text != newText) {
      _controller.text = newText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 110,
              child: Focus(
                onFocusChange: (hasFocus) {
                  _isUserEditing = hasFocus;
                  if (!hasFocus && _controller.text.trim().isEmpty) {
                    final defaultText = _defaultValue.toStringAsFixed(0);
                    setState(() {
                      _controller.text = defaultText;
                      _controller.selection = TextSelection.collapsed(
                        offset: defaultText.length,
                      );
                      _errorText = null; // Clear the error
                    });
                    widget.onChanged(_defaultValue);
                  }
                },
                child: TextField(
                  enableInteractiveSelection: false,
                  cursorColor: AppColors.lightChartLine,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.lightChartLine,
                    fontSize: 14,
                  ),
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightSliderInactive,
                    suffixText: 'mon',
                    suffixStyle: TextStyle(color: AppColors.lightChartLine),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorText: _errorText,
                    errorStyle: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      SliderTickMarkShape.noTickMark, // Hides tick marks
                ),
                child: Slider(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  activeColor: AppColors.lightChartLine,
                  inactiveColor: AppColors.lightSliderInactive,
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  onChanged: (val) {
                    widget.onChanged(val);
                    _controller.text = val.toStringAsFixed(0);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SliderForPercentage extends StatefulWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String suffix;
  final Function(double) onChanged;

  const SliderForPercentage({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    required this.suffix,
  });

  @override
  State<SliderForPercentage> createState() => _SliderForPercentageState();
}

class _SliderForPercentageState extends State<SliderForPercentage> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isUserEditing = false;
  late double _defaultValue;

  @override
  void initState() {
    super.initState();
    _defaultValue = widget.value;
    _controller = TextEditingController(
      text: _formatValue(_defaultValue.toString()),
    );

    _controller.addListener(() {
      if (!_isUserEditing) return;

      final text = _controller.text.trim();
      final parsed = double.tryParse(text);

      if (parsed == null || parsed < widget.min || parsed > widget.max) {
        setState(() {
          _errorText = 'Enter ${widget.min.toInt()} - ${widget.max.toInt()}';
        });
      } else {
        if (_errorText != null) {
          setState(() => _errorText = null);
        }
        widget.onChanged(parsed);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SliderForPercentage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = _formatValue(widget.value.toString());
    if (!_isUserEditing && _controller.text != newText) {
      _controller.text = newText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty || trimmed == '.' || trimmed.endsWith('.')) {
      return _defaultValue % 1 == 0
          ? _defaultValue.toInt().toString()
          : _defaultValue.toStringAsFixed(1);
    }

    final parsed = double.tryParse(trimmed);
    if (parsed == null || parsed < widget.min || parsed > widget.max) {
      return _defaultValue % 1 == 0
          ? _defaultValue.toInt().toString()
          : _defaultValue.toStringAsFixed(1);
    }

    return (parsed % 1 == 0)
        ? parsed.toInt().toString()
        : parsed.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 110,
              child: Focus(
                onFocusChange: (hasFocus) {
                  _isUserEditing = hasFocus;
                  if (!hasFocus) {
                    final text = _controller.text.trim();
                    final parsed = double.tryParse(text);
                    if (parsed == null ||
                        parsed < widget.min ||
                        parsed > widget.max ||
                        text.isEmpty) {
                      final defaultText = _formatValue(
                        _defaultValue.toString(),
                      );
                      setState(() {
                        _controller.text = defaultText;
                        _controller.selection = TextSelection.collapsed(
                          offset: defaultText.length,
                        );
                        _errorText = null;
                      });
                      widget.onChanged(_defaultValue);
                    }
                  }
                },
                child: TextField(
                  enableInteractiveSelection: false,
                  cursorColor: AppColors.lightChartLine,
                  style: TextStyle(
                    color: AppColors.lightChartLine,
                    fontSize: 14,
                  ),
                  controller: _controller,
                  textAlign: TextAlign.end,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightSliderInactive,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorText: _errorText,
                    errorStyle: TextStyle(fontSize: 11),
                    suffixText: '%',
                    suffixStyle: TextStyle(color: AppColors.lightChartLine),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      SliderTickMarkShape.noTickMark, // Hides tick marks
                ),
                child: Slider(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  activeColor: AppColors.lightChartLine,
                  inactiveColor: AppColors.lightSliderInactive,
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  onChanged: (val) {
                    widget.onChanged(val);
                    _controller.text = _formatValue(val.toString());
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SliderForYearMonth extends StatefulWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final Function(double) onChanged;

  const SliderForYearMonth({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  State<SliderForYearMonth> createState() => _SliderForYearMonthState();
}

class _SliderForYearMonthState extends State<SliderForYearMonth> {
  late TextEditingController _controller;
  bool _isEditing = false;
  bool isYearMode = true;
  late double _defaultValue;
  String? _errorText;

  @override
  @override
  void initState() {
    super.initState();
    _defaultValue = widget.value;
    _controller = TextEditingController();
    _updateControllerText(force: true);
    _controller.addListener(() {
      if (!_isEditing) return;
      final text = _controller.text;
      final parsed = double.tryParse(text);
      if (parsed == null) {
        setState(
          () =>
              _errorText =
                  'Enter ${isYearMode ? (widget.min / 12).round() : widget.min.toInt()} - ${isYearMode ? (widget.max / 12).round() : widget.max.toInt()}',
        );
        return;
      }

      final valueInMonths = isYearMode ? parsed * 12 : parsed;
      if (valueInMonths < widget.min || valueInMonths > widget.max) {
        setState(
          () =>
              _errorText =
                  'Enter ${isYearMode ? (widget.min / 12).round() : widget.min.toInt()} - ${isYearMode ? (widget.max / 12).round() : widget.max.toInt()}',
        );
        return;
      }

      setState(() => _errorText = null);
      widget.onChanged(valueInMonths);
    });
  }

  void _updateControllerText({bool force = false}) {
    final displayValue =
        isYearMode
            ? (widget.value / 12).toStringAsFixed(2)
            : widget.value.toStringAsFixed(2);

    if (force || !_isEditing) {
      _controller.text = displayValue;
    }
  }

  @override
  void didUpdateWidget(covariant SliderForYearMonth oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateControllerText();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty || trimmed == '.' || trimmed.endsWith('.')) {
      return isYearMode
          ? (_defaultValue / 12).toStringAsFixed(2)
          : _defaultValue.toStringAsFixed(0);
    }

    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return isYearMode
          ? (_defaultValue / 12).toStringAsFixed(2)
          : _defaultValue.toStringAsFixed(0);
    }

    final valueInMonths = isYearMode ? parsed * 12 : parsed;
    if (valueInMonths < widget.min || valueInMonths > widget.max) {
      return isYearMode
          ? (_defaultValue / 12).toStringAsFixed(2)
          : _defaultValue.toStringAsFixed(0);
    }

    return isYearMode
        ? (parsed % 1 == 0
            ? parsed.toInt().toString()
            : parsed.toStringAsFixed(2))
        : parsed.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final displayValue = isYearMode ? widget.value / 12 : widget.value;
    final divisions =
        isYearMode
            ? ((widget.max - widget.min) / 0.01).round()
            : (widget.max - widget.min).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                SizedBox(
                  width: 73,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() => _isEditing = hasFocus);
                      if (!hasFocus) {
                        final formatted = _formatValue(_controller.text);
                        final parsed = double.tryParse(formatted);

                        setState(() {
                          _errorText = null;
                          _controller.text = formatted;
                          _controller.selection = TextSelection.collapsed(
                            offset: formatted.length,
                          );
                        });

                        if (parsed != null) {
                          final valueInMonths =
                              isYearMode ? parsed * 12 : parsed;
                          widget.onChanged(valueInMonths);
                        }
                      }
                    },

                    child: TextField(
                      cursorColor: AppColors.lightChartLine,
                      enableInteractiveSelection: false,
                      style: TextStyle(
                        color: AppColors.lightChartLine,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightSliderInactive,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorText: _errorText,
                        errorStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ToggleButtons(
                  fillColor: AppColors.lightChartFill,
                  selectedColor: AppColors.lightChartFill,
                  borderRadius: BorderRadius.circular(5),
                  constraints: BoxConstraints(minWidth: 0, minHeight: 18),
                  isSelected: [!isYearMode, isYearMode],
                  onPressed: (index) {
                    setState(() {
                      isYearMode = index == 1;
                      _updateControllerText(force: true);
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        'M',
                        style: TextStyle(color: AppColors.lightChartLine),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'Y',
                        style: TextStyle(color: AppColors.lightChartLine),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  tickMarkShape:
                      SliderTickMarkShape.noTickMark, // Hides tick marks
                ),
                child: Slider(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                  value: displayValue,
                  min: isYearMode ? widget.min / 12 : widget.min,
                  max: isYearMode ? widget.max / 12 : widget.max,
                  activeColor: AppColors.lightChartLine,
                  inactiveColor: AppColors.lightSliderInactive,

                  onChanged: (val) {
                    final valueInMonths = isYearMode ? val * 12 : val;
                    widget.onChanged(valueInMonths);
                    _controller.text = val.toStringAsFixed(isYearMode ? 2 : 0);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
