var footers = ['', "#micropost_footer", "#article_footer", "", '', '', '#material_footer'];
var document_first_loading = true;


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

function onDocumentContentReady(menuIndex) {
    //如果是第1次进来,就会是loading状态,其它时候都是complete
    if (document.readyState == 'complete')
        document_first_loading = false;
    $(document).ready(function () {
        lightingMenuButtons(menuIndex);
        showFooter(menuIndex);
        // console.log($("").froalaEditor);
        // $("p").froalaEditor({
        //     language: "zh_cn"
        // });
        switch (menuIndex) {
            //首页
            case 0:
                onReadyAndResizeHome();
                break;
            //微博
            case 1:
                // onReadyAndResizeMicropostModal();
                break;
            //日志
            case 2:
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
