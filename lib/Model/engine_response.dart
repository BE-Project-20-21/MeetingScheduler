import 'package:flutter/material.dart';

class EngineResponse extends StatefulWidget {
  final int responseId;
  final String response;

  EngineResponse(this.responseId, this.response);

  @override
  _EngineResponseState createState() => _EngineResponseState();
}

class _EngineResponseState extends State<EngineResponse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Expanded(
          child: Text(
            widget.response,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 0,
              fontSize: 15.0,
            ),
          ),
        ),
        // ),
      ]),
    );
  }
}
