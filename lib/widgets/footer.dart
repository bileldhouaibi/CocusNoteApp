import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COCUS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Connecting industries. Empowering innovation.',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Work Life', style: TextStyle(color: Colors.white)),
                  Text('News', style: TextStyle(color: Colors.white70)),
                  Text('Projects', style: TextStyle(color: Colors.white70)),
                  Text('Events', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Company', style: TextStyle(color: Colors.white)),
                  Text('About us', style: TextStyle(color: Colors.white70)),
                  Text('Career', style: TextStyle(color: Colors.white70)),
                  Text('Contact', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Request offer', style: TextStyle(color: Colors.white)),
                  Text('info@cocus.com',
                      style: TextStyle(color: Colors.white70)),
                  Text('0211 87 542-860',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
