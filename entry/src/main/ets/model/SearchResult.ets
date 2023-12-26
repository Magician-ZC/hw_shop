import { ItemModel } from './ItemModel'

export default class SearchResult{
  public code: number
  public message: string
  public result: childResult
}

class childResult {
  public total: number
  public list: ItemModel[]
};
