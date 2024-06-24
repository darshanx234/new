import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  final controller;
  VoidCallback onsave;
  VoidCallback oncancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onsave,
      required this.oncancel});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Color.fromARGB(255, 255, 255, 255),
      content: Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: widget.controller,
              decoration: const InputDecoration(
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.black)),
                // focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.black)),
                hintText: "Enter Person name",
                labelText: "New Person",
                // labelStyle: TextStyle(color: Colors.black)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // backgroundColor: Color.fromARGB(255, 255, 153, 0),
                        ),
                    onPressed: () {
                      widget.onsave();
                      print("button clicked");
                    },
                    child: Text("Save")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Color.fromARGB(255, 255, 153, 0),
                          ),
                      onPressed: () {
                        widget.oncancel();
                      },
                      child: Text("Cancel")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
