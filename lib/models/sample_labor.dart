class SampleLabor {
  String name;
  String skill;
  String image;
  SampleLabor({
    required this.name,
    required this.skill,
    required this.image,
  });
}

List<SampleLabor> sampleLaborList = [
  SampleLabor(
    name: "Vinod khare",
    skill: "Tile mistri",
    image: "assets/sample_labor/1.jpg",
  ),
  SampleLabor(
    name: "Dhuma",
    skill: "Carpenter",
    image: "assets/sample_labor/2.jpg",
  ),
  SampleLabor(
    name: "Manmeet Singh",
    skill: "Shuttering",
    image: "assets/sample_labor/3.jpg",
  ),
  SampleLabor(
    name: "Sanjay",
    skill: "Majdoor",
    image: "assets/sample_labor/4.jpg",
  ),
  SampleLabor(
    name: "Hariya",
    skill: "Thekedaar",
    image: "assets/sample_labor/5.jpg",
  ),
];
