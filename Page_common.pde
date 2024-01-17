PImage image1;
PImage imagelog;
PImage imagecxlog;
String image1path="data/images/bg.png";
String imagelogpath="data/images/log.png";
String imagecxlogpath="data/images/cxlog.png";
void initCommonPage () {
  image1=loadImage(image1path);
  imagelog=loadImage(imagelogpath);
  imagecxlog=loadImage(imagecxlogpath);
}
void CommonPageDraw(){
  imageMode(CORNER);
 image(image1, 0, 0);
  image(imagelog, 75, 31);
  image(imagecxlog, 0, 646);
  strokeWeight(1);
  stroke(#FFFFFF);
  line(15, 220, 15+227, 220);
  line(363, 113, 363+924, 113);
  fill(255);
  textSize (19.05);
  textAlign(LEFT, TOP);
  text("DANGOTE CEMENT", 37, 146);
  textSize(14.43);
  text("ID: 3455", 97, 172);
}
