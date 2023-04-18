class SlideModel {
  String imagePath;
  String title;
  String description;

  SlideModel({this.imagePath, this.title, this.description});

  void setImagePath(String imagePath) {
    this.imagePath = imagePath;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  String getImagePath() {
    return this.imagePath;
  }

  String getTitle() {
    return this.title;
  }

  String getDescription() {
    return this.description;
  }
}

List<SlideModel> getSlides() {
  List<SlideModel> slides = List<SlideModel>();
  SlideModel slideModel = SlideModel();

  //first slide
  slideModel.setImagePath("assets/images/o1.jpg");
  slideModel.setTitle("Alumate");
  slideModel
      .setDescription("A social and business network for your classmates");
  slides.add(slideModel);

  slideModel = SlideModel();

  //second slide
  slideModel.setImagePath("assets/images/o2.jpg");
  slideModel.setTitle("Alumate");
  slideModel.setDescription("Easily connect with classmates");
  slides.add(slideModel);

  slideModel = SlideModel();

  //third slide
  slideModel.setImagePath("assets/images/o3.jpg");
  slideModel.setTitle("Alumate");
  slideModel.setDescription("Network and Grow");
  slides.add(slideModel);

  slideModel = SlideModel();

  return slides;
}
