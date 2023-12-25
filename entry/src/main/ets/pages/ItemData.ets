
export default class ItemData{

  /**
   * 列表项的文本。
   */
  title: Resource;
  /**
   * 列表项的图片。
   */
  img: Resource;
  /**
   * 列表项的其他资源。
   */
  others?: Resource;

  constructor(title: Resource, img: Resource, others?: Resource) {
    this.title = title;
    this.img = img;
    this.others = others;
  }
}