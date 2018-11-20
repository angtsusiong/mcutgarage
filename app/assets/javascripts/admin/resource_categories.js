var admin_resource_categories = {};

(function() {

    this.initialize = function() {
        var resource_category_id = $('#resource_category_id').val() || '';
        var master_show_tab = $('#master_show_tab').val() || '';

        // 依據傳入的 master_show_tab 參數來切換 show 頁面的 detail 頁籤內容
        if( typeof resource_category_id !== 'undefined' && resource_category_id != "" && typeof master_show_tab !== 'undefined' && master_show_tab != "" ) {
            $.ajax({
                url: "/admin/resource_categories/"+ resource_category_id +"/render_tab_content",
                method: 'get',
                dataType: 'html',
                data: { master_show_tab: master_show_tab }
            }).success(function(tab_html){
                if(tab_html !== '') {
                    $('.tab-pane.active').removeClass('active');
                    $('.tab.active').removeClass('active');

                    if($('#'+master_show_tab+'_tab').length === 0) {
                        master_show_tab = 'resource_category';
                    }

                    $('#'+master_show_tab+'_tab').addClass('active');
                    $('#'+master_show_tab+'_tabpanel').addClass('active').html($(tab_html));
                }
            }); 
        }



    };

}).apply(admin_resource_categories);

$(function() {
    admin_resource_categories.initialize();
});
