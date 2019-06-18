// function autoResizeMicropostModal(){
//     // e_modal=$(windo);
//     $(".modal textarea").css({'height':window.height()*0.3});
// }
//
// function onReadyAndResizeMicropostModal(){
//     autoResizeMicropostModal();
//     $(window).resize(function () {
//         autoResizeMicropostModal();
//     });
// }

function onDatePickChanged() {
    var s = $("#search_start_time");
    var e = $("#search_end_time");
    s.change(function () {
        cal(s, e);
    });
    e.change(function () {
        cal(e, s);
    });
    function cal(v1, v2) {
        var date_split = v1.val().split("-");
        // console.log(date_split);
        var date = new Date(date_split[0], parseInt(date_split[1]) - 1, parseInt(date_split[2]) + 1);
        // console.log(date);
        if (v1 == s)
            date.setDate(date.getDate() + 1);
        if (v1 == e)
            date.setDate(date.getDate() - 1);
        var year = date.getFullYear();
        var month = date.getMonth() + 1 >= 10 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
        var day = date.getDate() - 1 >= 10 ? date.getDate() - 1 : "0" + (date.getDate() - 1);
        // console.log(year + "-" + month + "-" + day);
        if (v1 == s)
            v2.attr("min", year + "-" + month + "-" + day);
        if (v1 == e)
            v2.attr("max", year + "-" + month + "-" + day);
    }
}
function onClickMicropostComment(id) {

    console.log("我是评论#micropost_main_comments_with_edit_" + id);
    $('#micropost_main_comments_with_edit_' + id.toString()).toggle('fast');
    // $('div').delegate('##micropost_main_comments_with_edit_+id')
    // $('.micropost_main_comments_with_edit').toggle();

    // return false;
}

function onClickRandomName(id) {
    console.log(name);
    var num = Math.floor(Math.random() * (RANDOM_NAMES.length));
    $("#comments_edit_form_" + id + " .comments_edit_form_name_field input").val(RANDOM_NAMES[num]);
}

function onClickGotoMicropostHome() {
    // console.log(window.history);
    window.history.back();
}


function onClickProgress(id) {
    $(id).html("<span class='fa fa-circle-notch fa-spin'></span>");
    setTimeout(function(){
        $(id).html("提交");
    },5000);
}

