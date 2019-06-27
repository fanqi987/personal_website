function showArticleEditorPage(func) {
    $("#article_editor").empty();
    $("#article_editor").removeClass();
    $("#article_editor").froalaEditor({
        heightMin: 300,
        language: "zh_cn",
        fontSizeDefaultSelection: '30',
        toolbarButtons: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        toolbarButtonsMD: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        toolbarButtonsSM: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        toolbarButtonsXS: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        placeholderText: "输入正文"
    });
    //转义从rails来的html
    var content = getDecodeHtml(func());
    //在编译器设置保存的content
    $("#article_editor").froalaEditor("html.set", content);
    $('.fr-toolbar>button:eq(0) i').addClass('fa-undo');
    $('.fr-toolbar>button:eq(1) i').addClass('fa-redo');
    $('#main_title_back').click(function () {
    });
    $('#article_footer').hide();
}

function onClickSubmitArticle() {
    var content = $("#article_write_submits input[type='hidden']");
    var article = $('#article_editor .fr-view').html();
    var t_article = $('#article_editor .fr-view').text()
    console.log("分解文章 " + t_article);
    if (!t_article || t_article.search(/^\s*$/) >= 0) {
        console.log(t_article);
        content.val("");
    }
    else {
        console.log("完整文章 " + article);
        content.val(article);
    }
    return false;
}

function onClickGotoDiaryHome(href) {
    var b = confirm('确定返回吗?没有保存的将会丢失!');
    if (b)
        location.href = href;
}

function splitFooter() {
    $('#article_footer>div a,' +
        '#article_footer>div div,' +
        '#article_footer>div button').css({"width": '33.333333%'});
}

function stopPopTrash() {
    $(".glyphicon-trash").on("click", function () {
        var b = window.confirm("确定删除吗?");
        if (b) {
            event.stopPropagation();
        } else {
            return false;
        }
    });
}

function setPagesHref(string) {
    $("#pagination a").each(function () {
        if ($(this).attr("href") != "#") {
            $(this).attr("href", $(this).attr("href") + string);
        } else {
            $(this).attr("href", "javascript:void(0)");
        }
    });
}

function copyUrl() {
    var clipboard = new Clipboard('.article_show_edits_copy', {
        text: function () {
            return location.href;
        }
    });
}
