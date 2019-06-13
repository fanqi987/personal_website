var footers = ['', "#micropost_footer", "#article_footer", "", '', '', '#material_footer'];
var document_first_loading = true;

var RANDOM_NAMES = ["妙蛙种子", "妙蛙草", "妙蛙花", "小火龙", "火恐龙", "喷火龙", "杰尼龟", "卡咪龟", "水箭龟", "绿毛虫",
    "铁甲蛹", "巴大蝶", "独角虫", "铁壳蛹", "大针蜂", "波波", "比比鸟", "大比鸟", "小拉达", "拉达", "烈雀", "大嘴雀",
    "阿柏蛇", "阿柏怪", "皮卡丘", "雷丘", "穿山鼠", "穿山王", "尼多兰", "尼多娜", "尼多后", "尼多郎", "尼多力诺",
    "尼多王", "皮皮", "皮可西", "六尾", "九尾", "胖丁", "胖可丁", "超音蝠", "大嘴蝠", "走路草", "臭臭花", "霸王花",
    "派拉斯", "派拉斯特", "毛球", "摩鲁蛾", "地鼠", "三地鼠", "喵喵", "猫老大", "可达鸭", "哥达鸭", "猴怪", "火爆猴",
    "卡蒂狗", "风速狗", "蚊香蝌蚪", "蚊香蛙", "快泳蛙", "凯西", "勇吉拉", "胡地", "腕力", "豪力", "怪力", "喇叭芽",
    "口呆花", "大食花", "玛瑙水母", "毒刺水母", "小拳石", "隆隆石", "隆隆岩", "小火马", "烈焰马", "呆呆兽", "呆河马",
    "小磁怪", "三合一磁怪", "大葱鸭", "嘟嘟", "嘟嘟利", "小海狮", "白海狮", "臭泥", "臭臭泥", "大舌贝", "铁甲贝",
    "鬼斯", "鬼斯通", "耿鬼", "大岩蛇", "素利普", "素利拍", "大钳蟹", "巨钳蟹", "r雷电球", "顽皮弹", "蛋蛋", "椰蛋树",
    "可拉可拉", "嘎拉嘎拉", "沙瓦郎", "艾比郎", "大舌头", "瓦斯弹", "双弹瓦斯", "铁甲犀牛", "铁甲暴龙", "吉利蛋",
    "蔓藤怪", "袋兽", "墨海马", "海刺龙", "角金鱼", "金鱼王", "海星星", "宝石海星", "吸盘魔偶", "飞天螳螂", "迷唇姐",
    "电击兽", "鸭嘴火龙", "凯罗斯", "肯泰罗", "鲤鱼王", "暴鲤龙", "拉普拉斯", "百变怪", "伊布", "水伊布", "雷伊布",
    "火伊布", "3D龙", "菊石兽", "多刺菊石兽", "化石盔", "镰刀盔", "化石翼龙", "卡比兽", "急冻鸟", "闪电鸟", "火焰鸟",
    "迷你龙", "哈克龙", "快龙", "超梦", "梦幻"];

function showFooter(index) {
    for (var i = 0; i < footers.length; i++) {
        $(footers[i]).hide();
    }
    $(footers[index]).show();
}

function lightingMenuButtons(index) {
    $('#nav_static_pages>li:eq(' + index + ')').addClass('active').siblings().removeClass('active');
    $('#nav-xs-list-static-pages>li:eq(' + index + ')').addClass('active').siblings().removeClass('active');
}

function progressMenus() {
    // $('li').click(function () {
    //     // alert('.nav_static_pages>li:eq('+$(this).index()+')');
    //     $('#nav_static_pages>li:eq(' + $(this).index() + ')').addClass('active').siblings().removeClass('active');
    //     $('#nav-xs-list-static-pages>li:eq(' + $(this).index() + ')').addClass('active').siblings().removeClass('active');
    //     // $(this).addClass("active");
    //     // console.log($(this).index());
    // });
    $('#nav-xs-static-pages').click(function () {
        $("#nav-xs-list-static-pages").toggle('fast');
    });

}

function onDocumentHeaderReady() {
    progressMenus();
}

function onDocumentContentReady(menuIndex, subMenuIndex, func) {
    //如果是第1次进来,就会是loading状态,其它时候都是complete
    if (document.readyState == 'complete')
        document_first_loading = false;
    $(document).ready(function () {
        lightingMenuButtons(menuIndex);
        showFooter(menuIndex);
        paginationWord();
        switch (menuIndex) {
            //首页
            case 0:
                onReadyAndResizeHome();
                break;
            //微博
            case 1:
                onDatePickChanged();
                // onReadyAndResizeMicropostModal();
                break;
            //日志
            case 2:
                switch (subMenuIndex) {
                    //日志创建,草稿编辑
                    case 0:
                        showArticleEditorPage(func);
                        break;
                    //日志展示
                    case 1:
                        splitFooter();
                        stopPopTrash();
                        break;
                }
                break;
            //娱乐
            case 3:
                initScrollboxHobby();
                break;
            //信息
            case 4:
                break;
            // 留言
            case 5:
                break;

        }
    });
}

function onDocumentContentReadyNotMenu(index) {
    $(document).ready(function () {
        showFooter(0);
        switch (index) {
            //其它 -1
            default:
                break;
        }
    });
}

function onRegisterSuccessfully(url) {
    window.setTimeout(function () {
        window.location.href = url;
    }, 3000);
}

function getDecodeHtml(html, content_id) {
    return $("#empty_div").html(html).text();
}

function paginationWord() {
    $(".pagination a:first").text("← 上一页");
    $(".pagination a:last").text("下一页 →");
    $(".pagination:has(.pagination)").css({
        // "margin-left": "auto",
        // "margin-right": "auto",
        "text-align": "center",
        "display": "block"
    });
}
