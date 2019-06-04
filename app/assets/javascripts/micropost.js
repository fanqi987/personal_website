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
    $("#micropost_main_comments_edit_form_" + id + " .micropost_main_comments_edit_form_name_field input").val(RANDOM_NAMES[num]);
}

