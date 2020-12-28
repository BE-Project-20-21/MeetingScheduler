import 'package:flutter/material.dart';
import 'package:authentication_app/Model/engine_response.dart';

class ERBubble extends StatelessWidget {
  final String response;
  ERBubble(this.response);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/robot.gif'),
                fit: BoxFit.fitWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              )
            ],
          ),
        ),
        // child: CircleAvatar(
        //   child: ClipOval(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Image(image: AssetImage('assets/images/robot.png')),
        //     ),
        //   ),
        //   radius: 25,
        // ),

        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 30, top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF478DE0),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EngineResponse(1, response),
            ),
          ),
        ),
      ],
    );
  }
}
