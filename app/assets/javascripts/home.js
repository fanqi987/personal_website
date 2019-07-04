function autoResizeFontHome() {
    var parent_e = $("#content_home>div>div>div");
    parent_e.children("p").css('font-size', parent_e.width() * 0.055);
    $('#micropost_content_first_word_home').css({
        'height': parent_e.width() * 0.14,
        'font-size': parent_e.width() * 0.14,
        'width': parent_e.width() * 0.16,
    });
    $('#micropost_time_home').css({
        'font-size': parent_e.width() * 0.05,
        'border-top-width': parent_e.width() * 0.007,
    });
    $('#article_title_home').css({
        'font-size':parent_e.width() * 0.04,
        'height':parent_e.width() * 0.06
    });
    $('#article_content_home,#article_time_home').css({
        'font-size':parent_e.width() * 0.03,
        // 'line-height':parent_e.width()*0.004
    });
    $('#message_board_name_home',).css({
        'font-size':parent_e.width() * 0.04,
    });
    $('#message_board_content_home,#message_board_time_home').css({
        'font-size':parent_e.width() * 0.03,
        // 'line-height':parent_e.width()*0.004
    });
    $('#materials_content_home p').css({
        'font-size':parent_e.width() * 0.06
        // 'line-height':parent_e.width()*0.004
    });
}
function onReadyAndResizeHome(){
    autoResizeFontHome();
    $(window).resize(function () {
        autoResizeFontHome();
    });
}