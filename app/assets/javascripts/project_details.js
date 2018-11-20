$( document ).ready(function(){


    $('[id*="step_tab_"]').click(function(){
        $('.tab-control.active').removeClass('active');
        $('.tab-pane.active').removeClass('active');
        var step = $(this).attr('class');
        var step_class = step.split(" ");
        var step_class_name = step_class[step_class.length-1];
        $('.'+step_class_name).addClass('active');
    });

});
