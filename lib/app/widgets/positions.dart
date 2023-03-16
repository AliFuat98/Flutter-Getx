List<Coordinate> getPositions() {
  return const [
    Coordinate(leftPosition: 400.0, topPosition: 285.0),
    Coordinate(leftPosition: 205.0, topPosition: 520.0),
    Coordinate(leftPosition: 410.0, topPosition: 800.0),
    Coordinate(leftPosition: 740.0, topPosition: 210.0),
    Coordinate(leftPosition: 800.0, topPosition: 463.0),
  ];
}

class Coordinate {
  final double leftPosition;
  final double topPosition;
  const Coordinate({
    required this.leftPosition,
    required this.topPosition,
  });
}
