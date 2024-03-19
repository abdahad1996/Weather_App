import 'package:flutter/material.dart';

class TemperatureSwitcher extends StatelessWidget {
  final bool isCelsius;
  final Function() onSwitch;

  const TemperatureSwitcher({
    super.key,
    required this.isCelsius,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    const boxHeight = 40.0;
    const boxWidth = 80.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: isCelsius
                        ? const Offset(1.0, 0.0)
                        : const Offset(-1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              },
              child: isCelsius
                  ? GestureDetector(
                      key: const ValueKey<int>(0),
                      child: Row(
                        children: [
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => onSwitch(),
                    )
                  : GestureDetector(
                      key: const ValueKey<int>(1),
                      child: Row(
                        children: [
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => onSwitch(),
                    ),
            ),
            IgnorePointer(
              child: Row(
                children: [
                  Container(
                    height: boxHeight,
                    width: boxWidth,
                    alignment: Alignment.center,
                    child: Text(
                      '°C',
                      style: TextStyle(
                        fontSize: 16,
                        color: isCelsius ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: boxHeight,
                    width: boxWidth,
                    alignment: Alignment.center,
                    child: Text(
                      '°F',
                      style: TextStyle(
                        fontSize: 16,
                        color: isCelsius ? Colors.grey.shade600 : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
