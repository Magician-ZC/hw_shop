import ItemData from './ItemData';
export class DataModel {
    /**
     * 获取轮播图的图片数据。
     *
     * @return {Array<Resource>} 返回轮播图图片数组。
     */
    getSwiperImages() {
        let swiperImages = [
            $r('app.media.fig1'),
            $r('app.media.fig2'),
            $r('app.media.fig3'),
            $r('app.media.fig4')
        ];
        return swiperImages;
    }
    /**
     * 第三部分的数据： 菜单列表数据
     * @returns
     */
    getFirstGridData() {
        let firstGridData = [
            new ItemData($r('app.string.my_love'), $r('app.media.love')),
            new ItemData($r('app.string.history_record'), $r('app.media.record')),
            new ItemData($r('app.string.message'), $r('app.media.message')),
            new ItemData($r('app.string.shopping_cart'), $r('app.media.shopping')),
            new ItemData($r('app.string.my_goal'), $r('app.media.target')),
            new ItemData($r('app.string.group'), $r('app.media.circle')),
            new ItemData($r('app.string.favorites'), $r('app.media.favorite')),
            new ItemData($r('app.string.recycle_bin'), $r('app.media.recycle'))
        ];
        return firstGridData;
    }
    /**
     * 第四部分的数据： 频道列表数据
     * @returns
     */
    getSecondGridData() {
        let secondGridData = [
            new ItemData($r('app.string.mainPage_top'), $r('app.media.top'), $r('app.string.mainPage_text_top')),
            new ItemData($r('app.string.mainPage_new'), $r('app.media.new'), $r('app.string.mainPage_text_new')),
            new ItemData($r('app.string.mainPage_brand'), $r('app.media.brand'), $r('app.string.mainPage_text_brand')),
            new ItemData($r('app.string.mainPage_found'), $r('app.media.found'), $r('app.string.mainPage_text_found'))
        ];
        return secondGridData;
    }
    /**
     * 获取设置列表的数据。
     *
     * @return {Array<PageResource>} 返回设置列表数据数组。
     */
    getSettingListData() {
        let settingListData = [
            new ItemData($r('app.string.setting_list_news'), $r('app.media.news'), $r("app.string.setting_toggle")),
            new ItemData($r('app.string.setting_list_data'), $r('app.media.data')),
            new ItemData($r('app.string.setting_list_menu'), $r('app.media.menu')),
            new ItemData($r('app.string.setting_list_about'), $r('app.media.about')),
            new ItemData($r('app.string.setting_list_storage'), $r('app.media.storage')),
            new ItemData($r('app.string.setting_list_privacy'), $r('app.media.privacy'))
        ];
        return settingListData;
    }
}
// 导入
export default new DataModel();
//# sourceMappingURL=DataModel.js.map