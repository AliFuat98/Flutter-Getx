
List<Coordinate> getPositions() {
  return const [
    Coordinate(leftPosition: 265.0,topPosition: 185.0),
    Coordinate(leftPosition: 132.0,topPosition: 349.0),
    Coordinate(leftPosition: 270.0,topPosition: 520.0),
    Coordinate(leftPosition: 500.0,topPosition: 135.0),
    Coordinate(leftPosition: 715.0,topPosition: 663.0),
  ];
}

class Coordinate{
  final double leftPosition;
  final double topPosition;
  const Coordinate({
    required this.leftPosition,
    required this.topPosition,
  });
}