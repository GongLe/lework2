if(! ('lework' in window) ) window['lework'] = {}
jQuery(function($) {
    //at some places we try to use 'tap' event instead of 'click' if jquery mobile plugin is available
    lework.click_event = $.fn.tap ? "tap" : "click";
});

lework.handleMenu = function ($) {
    var $sidebar = $('#sidebar'), $main = $('#main-content');
    //mini
    var $minimized = $sidebar.hasClass('menu-min');
    $('#sidebar-collapse').on(lework.click_event, function () {
        if ($sidebar.hasClass('menu-min')) {
            $sidebar.removeClass('menu-min');
            $(this).find('i').removeClass(' icon-double-angle-right')
                .addClass(' icon-double-angle-left');
            $main.removeClass('main-content-min')
        } else {
            $sidebar.addClass('menu-min');
            $(this).find('i')
                .addClass(' icon-double-angle-right')
                .removeClass(' icon-double-angle-left');
            $main.addClass('main-content-min')
        }

    });

    var touch = "ontouchend" in document;
    //opening submenu
    $('.nav-list').on(lework.click_event, function(e){
        //check to see if we have clicked on an element which is inside a .dropdown-toggle element?!
        //if so, it means we should toggle a submenu
        var link_element = $(e.target).closest('a');
        if(!link_element || link_element.length == 0) return;//if not clicked inside a link element

        $minimized = $sidebar.hasClass('menu-min');

        if(! link_element.hasClass('dropdown-toggle') ) {//it doesn't have a submenu return
            //just one thing before we return
            //if sidebar is collapsed(minimized) and we click on a first level menu item
            //and the click is on the icon, not on the menu text then let's cancel event and cancel navigation
            //Good for touch devices, that when the icon is tapped to see the menu text, navigation is cancelled
            //navigation is only done when menu text is tapped
            if($minimized && lework.click_event == "tap" &&
                link_element.get(0).parentNode.parentNode == this /*.nav-list*/ )//i.e. only level-1 links
            {
                var text = link_element.find('.menu-text').get(0);
                if( e.target != text && !$.contains(text , e.target) )//not clicking on the text or its children
                    return false;
            }

            return;
        }
        //
        var sub = link_element.next().get(0);

        //if we are opening this submenu, close all other submenus except the ".active" one
        if(! $(sub).is(':visible') ) {//if not open and visible, let's open it and make it visible
            var parent_ul = $(sub.parentNode).closest('ul');
            if($minimized && parent_ul.hasClass('nav-list')) return;

            parent_ul.find('> .open > .submenu').each(function(){
                //close all other open submenus except for the active one
                if(this != sub && !$(this.parentNode).hasClass('active')) {
                    $(this).slideUp(200).parent().removeClass('open');

                    //uncomment the following line to close all submenus on deeper levels when closing a submenu
                    //$(this).find('.open > .submenu').slideUp(0).parent().removeClass('open');
                }
            });
        } else {
            //uncomment the following line to close all submenus on deeper levels when closing a submenu
            //$(sub).find('.open > .submenu').slideUp(0).parent().removeClass('open');
        }

        if($minimized && $(sub.parentNode.parentNode).hasClass('nav-list')) return false;

        $(sub).slideToggle(200).parent().toggleClass('open');
        return false;
    })
}
lework.changeColorTheme = function(){
    var cssLinkTpl ='<link name="colorThemeStyle" rel="stylesheet" href="../static/assets/css/color.{theme}.css">',theme;
    $('#colorSelect').on('click','li',function(){
       //TODO 保存主题设置
        theme = $(this).attr('class');
        if (theme == 'default') {
            //clear all 'colorThemeStyle'
            $('link[name=colorThemeStyle]').remove()
        } else {
            $('body').append(cssLinkTpl.format({'theme': theme}))
        }

    })
}
$(function(){
    lework.handleMenu(jQuery)
    lework.changeColorTheme()
})