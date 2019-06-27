var material_code = '#8dc3ea';
var material_english = '#a3a380';
var material_read = '#cfd0bc';
var material_music = '#7296e5';
var material_paint = '#6fc018';
var material_plant = '#ef5e87';
var material_fitness = '#34352c';
var material_game = '#dfce73';


var CODE = "CODE";
var ENG = "ENG";
var READ = "READ";
var MUSIC = "MUSIC";
var PLANT = "PLANT";
var PAINT = "PAINT";
var FIT = "FIT";
var GAME = "GAME";

function setMaterialItemColor() {

    $(".material_main_content >div[name='" + CODE + "']").each(function () {
        $(this).css("backgroundColor", material_code);
    });
    $(".material_main_content >div[name='" + ENG + "']").each(function () {
        $(this).css("backgroundColor", material_english);
    });
    $(".material_main_content >div[name='" + READ + "']").each(function () {
        $(this).css("backgroundColor", material_read);
    });
    $(".material_main_content >div[name='" + MUSIC + "']").each(function () {
        $(this).css("backgroundColor", material_music);
    });
    $(".material_main_content >div[name='" + PLANT + "']").each(function () {
        $(this).css("backgroundColor", material_paint);
    });
    $(".material_main_content >div[name='" + PAINT + "']").each(function () {
        $(this).css("backgroundColor", material_plant);
    });
    $(".material_main_content >div[name='" + FIT + "']").each(function () {
        $(this).css("backgroundColor", material_fitness);
    });
    $(".material_main_content >div[name='" + GAME + "']").each(function () {
        $(this).css("backgroundColor", material_game);
    });
}

function deleteMaterial() {
    var b = confirm("确定删除这条素材吗?");
    if (b)
        event.stopPropagation();
    else
        return false;
}

function setMaterialTypeSelected(type) {
    if (!type || type == "") {
        $(".material_choose_section span:eq(0)").addClass("fas fa-check");
        return;
    }
    $(".material_choose_section a").each(function () {
        if ($(this).attr("name") == type) {
            $(this).find("span").addClass("fas fa-check");
            return;
        }
    });
}