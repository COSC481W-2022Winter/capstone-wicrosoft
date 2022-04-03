$(document).ready(function() {
    let counter = 0;

    $(":text").on("input", incrementCounterAndEnable);
    $("#type").on("change", incrementCounterAndEnable);
    $(".current_member_delete").on("click", incrementCounterAndEnable);
    $(".delete_project").on("click", incrementCounterAndEnable);
    $("#add_role_assignment").on("click", incrementCounterAndEnable);


    function incrementCounterAndEnable(){
        counter++;
        if (counter === 1){
            $(":submit").removeAttr("disabled");
        }
    }
})