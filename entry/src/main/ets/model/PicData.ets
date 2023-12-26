import List from '@ohos.util.List';
import { ItemModel } from './ItemModel';

export class PicData implements IDataSource {

  private data: List<ItemModel> = new List<ItemModel>()

  addData(item: ItemModel){
    this.data.add(item)
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {

  }

  registerDataChangeListener(listener: DataChangeListener): void {

  }

  getData(index: number): ItemModel {
    return this.data.get(index)
  }

  totalCount(): number {
    return this.data.length
  }


}
