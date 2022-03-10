import 'package:flutter/material.dart';

import '../../models/tools.dart';
import 'tools_page.dart';

class ToolsList extends StatelessWidget {
  const ToolsList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ToolsCard(size: size, tool: latestTools_list[0]),
          ToolsCard(size: size, tool: latestTools_list[1]),
          ToolsCard(size: size, tool: latestTools_list[2]),
          ToolsCard(size: size, tool: latestTools_list[3]),
          ToolsCard(size: size, tool: latestTools_list[4]),
          ToolsCard(size: size, tool: latestTools_list[5]),
          ToolsCard(size: size, tool: latestTools_list[6]),
          ToolsCard(size: size, tool: latestTools_list[7]),
          ToolsCard(size: size, tool: latestTools_list[8]),
          ToolsCard(size: size, tool: latestTools_list[9]),
          ToolsCard(size: size, tool: latestTools_list[10]),
          ToolsCard(size: size, tool: latestTools_list[11]),
          ToolsCard(size: size, tool: latestTools_list[12]),
        ],
      ),
    );
  }
}

class ToolsCard extends StatelessWidget {
  final Tools tool;
  const ToolsCard({
    Key? key,
    required this.size,
    required this.tool,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ToolsSceen(tool: tool)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              borderRadius: BorderRadius.circular(22),
              shadowColor: Colors.white,
              elevation: 10,
              child: SizedBox(
                // width: size.width * 0.53,
                // height: size.height * 0.15,
                width: 200,
                height: 125,
                child: Hero(
                  tag: tool.image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(tool.image, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(tool.name),
          ),
        ],
      ),
    );
  }
}
