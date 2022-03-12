// ignore_for_file: non_constant_identifier_names

class Labor {
  final String name;
  final String description;
  final String image;

  Labor({required this.name, required this.description, required this.image});
}

List<Labor> labor_list = [
  Labor(
    name: "Thekedaar",
    description: """
1. Experienced thekedaars with good command over labor. 

2. Vast knowledge of complex plans and processes, we make sure there is not a single day of delay in the project's completion.
      """,
    image: "assets/labor/thekedaar.png",
  ),
  Labor(
    name: "Painter",
    description: """
1 Trained painters with proper tools.

2 Knowledge to use high-speed paint machines.

3 Dedicated to creating almost zero mess to keep your new house, new. 
""",
    image: "assets/labor/painter.jpg",
  ),
  Labor(
    name: "Mistri",
    description: """
1 Provide neat and quality finish walls, pillars, plaster, everything.

2 They take care of every single element of your house like plant pots, rain drains, DPCs, etc.
""",
    image: "assets/labor/mistri.png",
  ),
  Labor(
    name: "Majdoor",
    description: """
1 They arrive on time, work even if no one is around to see them.

2 With the quality they deliver high speed in constructing your house.
""",
    image: "assets/labor/majdoor.png",
  ),
  Labor(
    name: "Carpenter",
    description: """
1 Highly skilled carpenter.

2 Long-lasting product quality.

3 Leaves no mess after work.
""",
    image: "assets/labor/carpenter.png",
  ),
  Labor(
    name: "Welder",
    description: """
1 Best in quality gates, girders, channels, railings, etc. at the fastest pace possible.

2 Facelift make sure only high-grade metal is used. 
""",
    image: "assets/labor/welder.jpg",
  ),
  Labor(
    name: "Plumber",
    description: """
1 Works according to the plumbing plans provided.

2 Attains vast knowledge in installing high-end jacuzzi systems, swimming pools, etc.
""",
    image: "assets/labor/plumber.jpg",
  ),
  Labor(
    name: "Glass labor",
    description: """
1 Professional in lifting every size of glass used in houses.

2  Free & careful transportation of glass directly from the manufacturer to your doorstep.

3 We take full responsibility if glass damage while installation. 
""",
    image: "assets/labor/glass_labor.jpg",
  ),
  Labor(
    name: "Electrician",
    description: """
1 Electrician work according to the requirements finalized by you.

2 Standardized color wires are used so that you can replace them even years later.
""",
    image: "assets/labor/electrician.png",
  ),
  Labor(
    name: "Tile/Marble Mistri",
    description: """
1 Use of plastic sheets keeps the original shine of the floor materials.

2 Experts in installing heating equipment for heated floors.

3 Heavy Machines are used for finishing after the completion of flooring.

4 Use of lifting tools minimizes the scope for breakage.
""",
    image: "assets/labor/Tile_Marble_Mistri.jpg",
  )
];
