final List imgList = [
  'images/Almonds.jpg',
  'images/Apples.jpg',
  'images/Bananas.jpg',
  'images/Raspberries.jpg',
  'images/Brazil Nuts.jpg',
  'images/Cashew Nuts.jpg',
  'images/Cherries.jpg',
  'images/Dragon Fruit.jpg',
  'images/Fig.jpg',
  'images/Grapefruit.jpg',
  'images/Grapes.jpg',
  'images/Hazelnuts.jpg',
  'images/Kiwi.jpg',
  'images/Lemon.jpg',
  'images/Lime.jpg',
  'images/Macadamia Nuts.jpg',
  'images/Mangoes.jpg',
  'images/Orange.jpg',
  'images/Papaya.jpg',
  'images/Peaches.jpg',
  'images/Peanuts.jpg',
  'images/Pears.jpg',
  'images/Pecan Nuts.jpg',
  'images/Pineapple.jpg',
  'images/Pistachio Nuts.jpg',
  'images/Pomegranate.jpg',
  'images/Raspberries.jpg',
  'images/Strawberry.jpg',
  'images/Walnuts.jpg',
  'images/Watermelons.jpg',
];

String nameExtractor (fileName) {
  var imageName = fileName.split('/').last;
  var matchedText = imageName.split('.').first;
  return matchedText;
}


