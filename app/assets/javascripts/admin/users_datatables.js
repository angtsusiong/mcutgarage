var admin_users = admin_users || {};
$.extend(true, admin_users, { 
	datatables: {}
});

(function() {
    var current_datatable;
    var all_datatables = {};

    var addRowClickEvent = function(row) {
        var id = $(row).attr('data-id')

        $(row).find('td:last-child').off('click').on('click', function() {
        });
    };

    var change_current_datatable = function(tab_key){
        current_datatable = all_datatables[tab_key];
    }

    var submit_filter = function(){
        current_datatable && current_datatable.draw();
    };

    var clear_filter = function(){
        current_datatable && current_datatable.search('').columns().search('').draw();
    };

    this.datatables.initialize = function() {
        var master_show_tab = $('#master_show_tab').val() || '';

        $.fn.dataTable.ext.errMode = function(s,h,m){}

        // 列表頁的 datatables 設定
        $('.users_table').each(function(){
            var table = $(this);
            var tab_key = table.data('tab_key');

            var editor = new $.fn.dataTable.Editor({
                ajax: {
                    url: '/admin/users/update_row',
                    type: 'PATCH'
                },
                table: "#"+ tab_key +"_users_table",
                idSrc: "DT_RowId",
                fields: [
                    {
                    fieldInfo: '',
                    label: 'email',
                    label: I18n.t('activerecord.attributes.user.email'),
                    name: 'email',
                },
                {
                    type: 'datetime',
                format: 'YYYY/MMM/D HH:mm',
                fieldInfo: '',
                    label: 'remember_created_at',
                    label: I18n.t('activerecord.attributes.user.remember_created_at'),
                    name: 'remember_created_at',
                },
                {
                    fieldInfo: '',
                    label: 'sign_in_count',
                    label: I18n.t('activerecord.attributes.user.sign_in_count'),
                    name: 'sign_in_count',
                },
                {
                    type: 'datetime',
                format: 'YYYY/MMM/D HH:mm',
                fieldInfo: '',
                    label: 'current_sign_in_at',
                    label: I18n.t('activerecord.attributes.user.current_sign_in_at'),
                    name: 'current_sign_in_at',
                },
                {
                    type: 'datetime',
                format: 'YYYY/MMM/D HH:mm',
                fieldInfo: '',
                    label: 'last_sign_in_at',
                    label: I18n.t('activerecord.attributes.user.last_sign_in_at'),
                    name: 'last_sign_in_at',
                },
                {
                    fieldInfo: '',
                    label: 'current_sign_in_ip',
                    label: I18n.t('activerecord.attributes.user.current_sign_in_ip'),
                    name: 'current_sign_in_ip',
                },
                {
                    fieldInfo: '',
                    label: 'last_sign_in_ip',
                    label: I18n.t('activerecord.attributes.user.last_sign_in_ip'),
                    name: 'last_sign_in_ip',
                },
                ],
            });

            var datatable = table.DataTable({
                language: datatablesUtils.datatables_language(),
                paging: true,
                responsive: true,
                searching: true,
                processing: false,
                serverSide: true,
                stateSave: false,
                autoWidth: false,
                select: true,
                deferLoading: false,
                dom: 'Brtip"bottom"l',
                ajax: {
                    url: '/admin/users/datatables.json',
                    dataSrc: 'data',
                    type: 'POST',
                    data: {
                    },
                },
                columns:[
                        {
                    data: 'email',
                    name: 'email_cont',
                    visible: true,
                    orderable: false,
                    className: 'editable col-email',
                    editField: 'email',
                },
                {
                    data: 'remember_created_at',
                    name: 'remember_created_at_between',
                    visible: true,
                    orderable: false,
                    className: 'editable col-remember_created_at',
                    editField: 'remember_created_at',
                },
                {
                    data: 'sign_in_count',
                    name: 'sign_in_count_between',
                    visible: true,
                    orderable: false,
                    className: 'editable col-sign_in_count',
                    editField: 'sign_in_count',
                },
                {
                    data: 'current_sign_in_at',
                    name: 'current_sign_in_at_between',
                    visible: true,
                    orderable: false,
                    className: 'editable col-current_sign_in_at',
                    editField: 'current_sign_in_at',
                },
                {
                    data: 'last_sign_in_at',
                    name: 'last_sign_in_at_between',
                    visible: true,
                    orderable: false,
                    className: 'editable col-last_sign_in_at',
                    editField: 'last_sign_in_at',
                },
                {
                    data: 'current_sign_in_ip',
                    name: 'current_sign_in_ip_cont',
                    visible: true,
                    orderable: false,
                    className: 'editable col-current_sign_in_ip',
                    editField: 'current_sign_in_ip',
                },
                {
                    data: 'last_sign_in_ip',
                    name: 'last_sign_in_ip_cont',
                    visible: true,
                    orderable: false,
                    className: 'editable col-last_sign_in_ip',
                    editField: 'last_sign_in_ip',
                },
                    {
                        // 操作
                        data: null,
                        visible: true,
                        orderable: false,
                        render: function ( data, type, full, meta ) {
                            var id = data.id;
                            var actions = '<a href="/admin/users/' + id + '?master_show_tab='+ master_show_tab +'" class="btn btn-default m-r-10"><span class="fa fa-eye fa-lg"></span></a>';
                            actions += '<a href="/admin/users/' + id + '/edit?master_show_tab='+ master_show_tab +'" class="btn btn-default m-r-10"><span class="fa fa-pencil fa-lg"></span></a>';
                            actions += '<a href="/admin/users/' + id + '" data-confirm="確定刪除?" class="btn btn-default" rel="nofollow" data-method="delete"><span class="fa fa-trash fa-lg"></span></a>';
                            return actions;
                        },
                    },
                ],
                order: [[ 0, "desc" ]],
                lengthMenu: [
                    [10, 20, 50, 100, 1000],
                    [10, 20, 50, 100, I18n.t('helpers.datatables.length_menu_all')]
                ],
                buttons: [
                    { 
                        extend: 'copy', text: 'Copy', className: 'btn btn-default datatables_buttons', 
                        exportOptions: { columns: ':visible:not(:last)' },
                        init: function(api, node, config) {
                            $(node).removeClass('dt-button');
                        }
                    },
                    { 
                        extend: 'csv', text: 'CSV', className: 'btn btn-default datatables_buttons', 
                        exportOptions: { columns: ':visible:not(:last)' },
                        init: function(api, node, config) {
                            $(node).removeClass('dt-button');
                        }
                    },
                    { 
                        extend: 'excel', text: 'Excel', className: 'btn btn-default datatables_buttons', 
                        exportOptions: { columns: ':visible:not(:last)' },
                        init: function(api, node, config) {
                            $(node).removeClass('dt-button');
                        }
                    },
                    { 
                        extend: 'pdf', text: 'PDF', className: 'btn btn-default datatables_buttons', 
                        exportOptions: { columns: ':visible:not(:last)' },
                        init: function(api, node, config) {
                            $(node).removeClass('dt-button');
                        }
                    },
                    { 
                        extend: 'print', text: 'Print', className: 'btn btn-default datatables_buttons', 
                        exportOptions: { columns: ':visible:not(:last)' },
                        init: function(api, node, config) {
                            $(node).removeClass('dt-button');
                        }
                    },
                ],
                    iDisplayLength: 10,
                rowCallback: function( row, data, index ) {
                    $(row).attr('data-id', data.id);

    
                    addRowClickEvent(row);
                },
                fnPreDrawCallback: function(){
                    $('.dataTables_processing').css("visibility","visible");
                    $('.dataTables_processing').css({"display": "block", "z-index": 10000 })
                },
            });

            $("#"+ tab_key +"_users_table").on( 'click', 'tbody td.editable', function (e) {
                // Activate an editor on click of a table cell
                editor.bubble( this, {
                    buttons: false,
                } );
            } );

    
            editor.on( 'initEdit', function () {
                // Disable for edit (re-ordering is performed by click and drag)
            } );

            all_datatables[tab_key] = datatable;
        });

        // 關鍵字查詢
        $('#keyword_search').keyup(function(e){
            datatablesUtils.keyword_filter(all_datatables, $(this).val());
        });

        // 查詢條件值更新事件處理器
        $('.filter-condition-panel .filter-condition').change(function(e){
            datatablesUtils.column_string_filter(all_datatables, e.target.name);
        });

        $('.filter-condition-panel .filter-range-condition').change(function(e){
            datatablesUtils.column_range_filter(all_datatables, e.target.name);
        });

        $('.filter-condition-panel .filter-select-condition').on('select2:close', function(e){
            datatablesUtils.column_select_filter(all_datatables, e.target.name);
        });

        // 送出查詢
        $('button.filter-button').click(function(e){
            submit_filter();
        });

        // 清空查詢
        $('button.reset-button').click(function(e){
            $('input').val('');
            $('select').val('').trigger('change.select2');
            clear_filter();
        });

        // 點擊頁籤
        $('.user__tab').on('click', function(){
            var tab = $(this);
            var tab_key = tab.data('tab_key');
            var tab_column_name = tab.data('tab_column_name');
            change_current_datatable(tab_key);
            datatablesUtils.column_filter(current_datatable, tab_column_name, tab_key == "all" ? '' : tab_key);
            submit_filter();
        });

        // 初次進入頁面
        change_current_datatable('all');
        clear_filter();
    };

}).apply(admin_users);

$(function() {
    admin_users.datatables.initialize();
});
