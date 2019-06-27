function initScrollboxHobby() {
    var owl = $(".owl-carousel");
    var owl_navs = $('.owl-carousel .owl-nav');
    var owl_dots = $('.owl-carousel .owl-dots');
    var owl_cloned = $('.owl-carousel .owl-stage-outer .owl-stage .cloned');

    if (owl.hasClass('owl-loaded')) {
        // owl.html(owl.data('originalHtml')).removeClass('owl-nav owl-dots cloned');
        // owl.html(owl.data('originalHtml')).removeClass('owl-theme owl-loaded owl-drag');
        owl_navs.remove();
        owl_dots.remove();
        owl_cloned.remove();
    }
    owl.owlCarousel({
        // loop: true,
        // dots:false,
        items: 1,
        nav: true
    });
}


function initSwiper() {
    var slidesPerView = 1;
    if (document.documentElement.clientWidth > 1200)
        slidesPerView = 2;
    var swiper = new Swiper('.swiper-container', {
        speed: 400,
        spaceBetween: 30,
        centeredSlides: true,
        effect: 'coverflow',
        slidesPerView: slidesPerView,
        coverflow: {
            rotate: 50,
            stretch: 0,
            depth: 100,
            modifier: 1,
            slideShadows: true
        },
        preloadImages: false,
        // Enable lazy loading
        lazyLoading: true,
        lazyLoadingInPrevNext: true,
        onInit: function (swiper) {
            var image_id = $(".swiper-slide-active").attr("name");
            var image_title = $(".swiper-slide-active .hobby_gallery_item_title").text();
            var image_content = $(".swiper-slide-active .hobby_gallery_item_content").text();
            var image_created_time = $(".swiper-slide-active .hobby_gallery_item_time").text();
            var image_like = $(".swiper-slide-active .hobby_gallery_item_like").text();
            var image_cover = $(".swiper-slide-active .hobby_gallery_item_cover").text();
            $(".picture_id").each(function () {
                $(this).val(image_id);
                console.log($(this));
            });
            $(".hobby_picture_name").text(image_title);
            $(".hobby_picture_content").text(image_content);
            $(".hobby_picture_time").text(image_created_time);
            $(".hobby_picture_edits_like").text(image_like);
            $(".hobby_picture_edits_cover").removeClass("fa-square fa-check-square");
            if (image_cover == "true") {
                $(".hobby_picture_edits_cover").addClass("fa-check-square");
            } else {
                $(".hobby_picture_edits_cover").addClass("fa-square");
            }
        },
        onTransitionEnd: function (swiper) {
            var image_id = $(".swiper-slide-active").attr("name");
            var image_title = $(".swiper-slide-active .hobby_gallery_item_title").text();
            var image_content = $(".swiper-slide-active .hobby_gallery_item_content").text();
            var image_created_time = $(".swiper-slide-active .hobby_gallery_item_time").text();
            var image_like = $(".swiper-slide-active .hobby_gallery_item_like").text();
            var image_cover = $(".swiper-slide-active .hobby_gallery_item_cover").text();
            $(".picture_id").each(function () {
                $(this).val(image_id);
                console.log($(this));
            });
            $(".hobby_picture_name").animate({
                opacity: 0
            }, 10, function () {
                $(".hobby_picture_name").text(image_title);
            });
            $(".hobby_picture_content").animate({
                opacity: 0
            }, 10, function () {
                $(".hobby_picture_content").text(image_content);
            });
            $(".hobby_picture_time").animate({
                opacity: 0
            }, 10, function () {
                $(".hobby_picture_time").text(image_created_time);
            });
            $(".hobby_picture_edits_like").animate({
                opacity: 0
            }, 10, function () {
                $(".hobby_picture_edits_like").text(image_like);
            });
            $(".hobby_picture_edits_cover").animate({
                opacity: 0
            }, 10, function () {
                $(".hobby_picture_edits_cover").removeClass("fa-square fa-check-square");
                if (image_cover == "true") {
                    $(".hobby_picture_edits_cover").addClass("fa-check-square");
                } else {
                    $(".hobby_picture_edits_cover").addClass("fa-square");
                }
            });
            $(".hobby_picture_name," +
                ".hobby_picture_content," +
                ".hobby_picture_time," +
                ".hobby_picture_edits_like," +
                ".hobby_picture_edits_cover").animate({
                opacity: 1
            });
            $(".hobby_picture_content_editor").hide();
            $(".hobby_picture_content").show();
            $(".hobby_picture_name_editor").hide();
            $(".hobby_picture_name").show();
        }
    });
}

function onRefreshImages(node) {
    $(node).addClass("fa-spin");
    $(".hobby_edits_post").attr("disabled", true);
    setTimeout(function () {
        $(node).removeClass("fa-spin");
    }, 2000);
}

var selectd_image_index = 0;
var maxImageFileSize = 100000;

function initFileUploader(path) {
    $('#hobby_chooser').fileupload({
        url: path,
        type: 'post',
        dataType: 'html',
        previewMaxWidth: 720,
        previewMaxHeight: 100000,
        loadImageMaxFileSize: 10000000,
        // limitMultiFileUploads: 1,
        // multipart: false,
        autoUpload: false
    });
}

function bindFileUploadAdd() {
    $('#hobby_chooser').bind("fileuploadadd", function (e, data) {
        console.log("添加文件了!");
        // console.log("这里是add------------------");
        $(".hobby_edits_post").attr('disabled', false);
        data.context = $(".hobby_edits_post").click(function () {
            if (getCookie("created_hobby_id").length > 0)
                data.submit();
            else {
                showToast("请先创建画廊哦!");
            }
        });
        selectd_image_index = 0;
        $(".hobby_selected .hobby_selected_picture_item").each(function () {
            $(this).remove();
        });
        $(".hobby_uploaded_picture_item").each(function () {
            $(this).find(".hobby_selected_picture_bar_tips").text("已上传");
        });
        // delete_select_image_indexes = [];
    });
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i].trim();
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function bindFileUploadProcessAlways(selected_view) {
    $('#hobby_chooser').bind("fileuploadprocessalways", function (e, data) {
        console.log("这里是处理加入队列完成的process------------------");
        console.log(data);
        var index = data.index;
        var preview = data.files[index].preview;
        if (!preview) {
            $(".hobby_edits_post").attr('disabled', true);
            showToast("文件限制为" + maxImageFileSize * 1.0 / 1000 / 1000 + "MB,请重新选择");
            return;
        }
        // console.log(index);
        // console.log(preview);
        // console.log(preview.getContext("2d"));
        // console.log(preview.toDataURL("image/png"));
        selectd_image_index += 1;
        // console.log(".hobby_selected>div:eq(" + (selectd_image_index - 1) + ")");
        // console.log($(".hobby_selected>div:eq(" + (selectd_image_index - 1) + ")"));
        $(".hobby_selected").append(selected_view);
        $(".hobby_selected .hobby_selected_picture_item:eq(" + (selectd_image_index - 1).toString() +
            ")").attr("name", selectd_image_index);
        $('.hobby_selected .hobby_selected_picture_item img:eq(' + (selectd_image_index - 1).toString() + ')').attr({
            "src": preview.toDataURL("image/png")
        });
        $(".hobby_selected .hobby_selected_picture_item .hobby_selected_picture_item_name:eq(" +
            (selectd_image_index - 1).toString() + ")").html(data.files[0].name);
    });
}

function bindFileUploadStart() {
    $('#hobby_chooser').bind("fileuploadstart", function (e, data) {
        console.log("开始上传了!");
    });
}

function bindFileUploadProgress() {
    $('#hobby_chooser').bind("fileuploadprogress", function (e, data) {
        console.log("这里是正在进行上传的事件progress------------------");
        console.log("上传进度:" + data.loaded + " " + data.total);
        var i = getUploadingFileIndex(data);
        var progress = (data.loaded * 1.0 * 100 / data.total).toFixed(2).toString() + "%";
        $('.hobby_selected .hobby_selected_picture_item .hobby_selected_picture_bar_progress:eq(' + i
            + ')').css("width", progress);
        $('.hobby_selected .hobby_selected_picture_item .hobby_selected_picture_bar_tips:eq(' + i
            + ')').text(progress);
    });
}

function bindFileUploadDone(flash_do, flash_view) {
    $('#hobby_chooser').bind("fileuploaddone", function (e, data) {
        console.log("上传成功了!");
        flash_do();
        $(".hobby_selected_pictures_flash ").html(flash_view);
        $(".hobby_edits_post").attr('disabled', true);
        // console.log(data.context);
        $(".hobby_selected_picture_item").each(function () {
            $(this).removeClass();
            $(this).addClass("hobby_uploaded_picture_item");
        });
        // showToast("上传成功!");
        $(".hobby_edits_post").off("click");
    });
}

function bindFileUploadFail(flash_do, flash_view) {
    $('#hobby_chooser').bind("fileuploadfail", function (e, data) {
        console.log("上传失败了!");
        flash_do();
        $(".hobby_selected_pictures_flash ").html(flash_view);
        showToast("上传失败,请刷新后重试!");
    });
}

function bindFileUploadStop() {
    $('#hobby_chooser').bind("fileuploadstop", function (e, data) {
        console.log("上传结束了!!");
        // flash_do();
        // $(".hobby_selected_pictures_flash ").html(flash_view);
        // showToast("上传失败,请刷新后重试!");
    });
}

//获取的是eq顺序
function getUploadingFileIndex(data) {
    for (var i = 0; i < data.originalFiles.length; i++) {
        // console.log("两个文件是否相同 ");
        // console.log(data.files[0] == data.originalFiles[i]);
        if (data.files[0] == data.originalFiles[i])
            return i;
    }
}

function onShowGalleryInfo() {
    var info_node = $(".hobby_show_gallery_info");
    if (info_node.css("opacity") == "0") {
        info_node.css("display", "block");
        info_node.animate({
            top: '3',
            opacity: '1'
        });
    } else {
        info_node.animate({
            top: '-10%',
            opacity: '0'
        });
        // info_node.hide();
    }
}

function onClickShowPictureEdits(node) {
    if ($('.hobby_picture_edits_item').css("opacity") == "0") {
        $(node).removeClass("fa-angle-left");
        $(node).addClass("fa-angle-right");
        $('.hobby_picture_edits_item').animate({
            'margin-left': '-10%',
            opacity: 1
        });
    } else {
        $(node).removeClass("fa-angle-right");
        $(node).add("fa-angle-left");
        $('.hobby_picture_edits_item').animate({
            'margin-left': '0',
            opacity: 0
        });
    }
}

function setPictureName(node) {
    $(node).hide();
    $(".hobby_picture_content_editor").hide();
    $(".hobby_picture_content").show();
    $(".hobby_picture_name_editor").css("display", "inline-block");
    $("#picture_title").val($(node).text());
}

function setPictureContent(node) {
    $(node).hide();
    $(".hobby_picture_name_editor").hide();
    $(".hobby_picture_name").show();
    $(".hobby_picture_content_editor").show();
    $("#picture_content").val($(node).text());
}