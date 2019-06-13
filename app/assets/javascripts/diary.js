function showArticleWritePage() {
    // $("#article_editor").hide();
    // $("#article_aside").hide("fast");
    // $("#article_main_content").hide("fast");
    // $("#article_paginate").hide("fast");
    // $("#article_empty").hide("fast");
    // $("#article_empty+p").hide("fast");
    // $('#article_footer').hide('fast');
    // $("#article_write_div").show("fast");
    // $('#article_main').addClass('col-xs-12');
    // $('#article_main').removeClass('col-md-9 col-sm-12');
    // $('#main_title_back').click(function(){
    //     hideArticleWritePage();
    // });
    $("#article_editor").empty();
    $("#article_editor").removeClass();
    $("#article_editor").froalaEditor({
        autofocus: true,
        heightMin: 300,
        language: "zh_cn",
        autofocus: true,
        fontSizeDefaultSelection: '30',
        toolbarButtons: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        toolbarButtonsMD: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        toolbarButtonsSM: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        toolbarButtonsXS: ["undo", "redo", "bold", 'italic', 'underline', 'fontSize', 'align', 'color'],
        placeholderText: null
    });
    $("#article_editor").froalaEditor("html.set","<p><</p>>");
    console.log($("#article_editor").froalaEditor("html.get",true));

    // $("#article_editor").froalaEditor("html.set","<p><</p>>");

    // $("#article_editor").froalaEditor("html.set","<p>"+getDiaryContent()+"</p>");
    // console.log($.froalaEditor);
    // editor.froalaEditor().html.set(getDiaryContent());

    // var editor2 = new FroalaEditor('#article_editor', function () {
    //     console.log(editor2.html.get());
    // });
    // console.log(editor2);
    // editor.clean.html(getDiaryContent());
    // console.log($(".fr-view p").html());
    // $("#article_editor").show("fast");
    $('.fr-toolbar>button:eq(0) i').addClass('fa-undo');
    $('.fr-toolbar>button:eq(1) i').addClass('fa-redo');
    $('#main_title_back').click(function () {
    });
    $('#article_footer').hide();
    $('.fr-view').attr("id", "diary_content");
    $('.fr-view').attr("name", "diary[content]");
    $('.fr-view').attr("type", "text");

    // $('form').addClass("form-inline");
    // $('#main_title_back').show('fast');
}


function onClickSubmitArticle() {
    var content = $("#article_write_submits input[type='hidden']");
    var article = $('#article_editor .fr-view>p').html();
    var t_article = article.replace(/<.+?>/, "");
    console.log(t_article);
    // console.log(t_article.search(/^\s*$/));
    if (!t_article || t_article.search(/^\s*$/) >= 0) {
        console.log(t_article);
        content.val("");
    }
    else {
        console.log(article);
        content.val(article);
    }
    return false;
}