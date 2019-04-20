

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
    $(document).ready(function () {
        lightingMenuButtons(menuIndex);
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