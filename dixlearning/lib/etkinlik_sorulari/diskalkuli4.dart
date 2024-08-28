import 'package:flutter/material.dart';

class MathActivity extends StatefulWidget {
  const MathActivity({super.key});

  @override
  _MathActivityState createState() => _MathActivityState();
}

class _MathActivityState extends State<MathActivity> {
  List<String> operations = ['+', '-', '×', '÷'];
  List<String?> selectedOperations = [null, null, null, null];
  List<bool> results = [false, false, false, false];
  bool checked = false;

  void checkAnswers() {
    setState(() {
      checked = true;
      results[0] = selectedOperations[0] == '÷';
      results[1] = selectedOperations[1] == '-';
      results[2] = selectedOperations[2] == '×';
      results[3] = selectedOperations[3] == '+';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            questionRow(0, '81', '9', '9'),
            SizedBox(height: 20),
            questionRow(1, '16', '6', '10'),
            SizedBox(height: 20),
            questionRow(2, '7', '3', '21'),
            SizedBox(height: 20),
            questionRow(3, '14', '8', '22'),
            SizedBox(height: 40),
            Wrap(
              spacing: 20,
              children: operations.map((operation) {
                return Draggable<String>(
                  data: operation,
                  child: operationWidget(operation),
                  feedback: operationWidget(operation),
                  childWhenDragging: operationWidget(operation, dragging: true),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: checkAnswers,
              child: const Text('Kontrol Et'),
            ),
            if (checked) ...[
              SizedBox(height: 20),
              Text(
                'Doğru: ${results.where((r) => r).length}, Yanlış: ${results.where((r) => !r).length}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget questionRow(int index, String num1, String num2, String result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num1,
          style: const TextStyle(fontSize: 18),
        ),
        SizedBox(width: 10),
        DragTarget<String>(
          onAccept: (data) {
            setState(() {
              selectedOperations[index] = data;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: selectedOperations[index] == null
                    ? Colors.transparent
                    : Colors.grey[200],
              ),
              child: Center(
                child: Text(
                  selectedOperations[index] ?? '',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        ),
        SizedBox(width: 10),
        Text(
          num2,
          style: const TextStyle(fontSize: 18),
        ),
        SizedBox(width: 10),
        Text(
          '= $result',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget operationWidget(String operation, {bool dragging = false}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: dragging ? Colors.grey : Color.fromARGB(190, 59, 179, 235),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          operation,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
