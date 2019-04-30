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
        loop: true,
        // dots:false,
        items: 1,
        nav: true
    });

    // if(owl.hasClass('.owl-loaded'))
    // {
    //     owl.html(owl.data('originalHtml')).removeClass('owl-theme owl-loaded owl-drag');
    // }else{
    //     owl.data('originalHtml',owl.html());
    // }
    // owl.data('originalHtml',owl.html());
    // $('.item_of_hobby_next').click(function () {
    //     owl.trigger('next.owl.carousel');
    // });
    // $('.item_of_hobby_prev').click(function () {
    //     owl.trigger('prev.owl.carousel');
    // });
    // $('.item_of_hobby_destroy').click(function () {
    //     owl.trigger('destroy.owl.carousel');
    // });
}