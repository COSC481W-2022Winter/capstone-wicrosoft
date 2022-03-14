$(document).ready(function(){
    $("#notification_section").on("click", function(){
        $.ajax({
            type: "GET",
            url: "getNotifications",
            success: function(data){
                updateNotificationCount(data);
            },
            dataType: "json"
        })
    })

    function updateNotificationCount(data)
    {
        let count = data.suggestions.length;
        console.log($("#notification_count"));
        $("#notification_count")[0].innerText = count;
    }

})