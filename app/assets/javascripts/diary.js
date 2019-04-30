function showArticleWritePage() {
    $("#article_editor").hide();
    $("#article_aside").hide("fast");
    $("#article_main_content").hide("fast");
    $("#article_paginate").hide("fast");
    $("#article_empty").hide("fast");
    $("#article_empty+p").hide("fast");
    $('#article_footer').hide('fast');
    $("#article_write_div").show("fast");
    $('#article_main_div').addClass('col-xs-12');
    $('#article_main_div').removeClass('col-md-9 col-sm-12');

    $('#article_main_title_back').click(function(){
        hideArticleWritePage();
    });
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
    $("#article_editor").show("fast");
    $('#undo-1 i').addClass('fa-undo');
    $('#redo-1 i').addClass('fa-redo');
    $('#article_main_title_back').show('fast');


}

function hideArticleWritePage() {
    $("#article_editor").hide('fast');
    $("#article_aside").show("fast");
    $("#article_main_content").show("fast");
    $("#article_paginate").show("fast");
    $("#article_empty").show("fast");
    $("#article_empty+p").show("fast");
    // $("#article_main_div").css({"class": "col-md-9 col-sm-12"});
    $('#article_main_div').removeClass('col-xs-12');
    $('#article_main_div').addClass('col-md-9 col-sm-12');
    $("#article_write_div").hide("fast");
    $('#article_main_title_back').hide('fast');
    $('#article_footer').show();

    $('#article_main_title_back').click(function(){
    });

}