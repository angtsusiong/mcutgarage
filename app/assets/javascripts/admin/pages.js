var admin_pages = {};

(function() {

    this.initialize = function() {
        var page_id = $('#page_id').val() || '';
        var master_show_tab = $('#master_show_tab').val() || '';

        // 依據傳入的 master_show_tab 參數來切換 show 頁面的 detail 頁籤內容
        if( typeof page_id !== 'undefined' && page_id != "" && typeof master_show_tab !== 'undefined' && master_show_tab != "" ) {
            $.ajax({
                url: "/admin/pages/"+ page_id +"/render_tab_content",
                method: 'get',
                dataType: 'html',
                data: { master_show_tab: master_show_tab }
            }).success(function(tab_html){
                if(tab_html !== '') {
                    $('.tab-pane.active').removeClass('active');
                    $('.tab.active').removeClass('active');

                    if($('#'+master_show_tab+'_tab').length === 0) {
                        master_show_tab = 'page';
                    }

                    $('#'+master_show_tab+'_tab').addClass('active');
                    $('#'+master_show_tab+'_tabpanel').addClass('active').html($(tab_html));
                }
            }); 
        }



    };

}).apply(admin_pages);

$(function() {
    admin_pages.initialize();
});
