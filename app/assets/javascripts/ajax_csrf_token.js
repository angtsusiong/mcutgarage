$(function(){
    // 讓 ajax request 都會加上 CSRF token
    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });
});
