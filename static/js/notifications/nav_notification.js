$(document).ready(function(){
    ajaxGetNotifications();
    setInterval(ajaxGetNotifications, 5000);

    function updateNotificationCount(data)
    {
        console.log(data);
        let count = data.suggestions.length;
        if (count === 0)  { return; }

        $(".notification_indicator").each(function(){
            $( this ).removeClass("d-none");
        })
        $("#notification_section").removeClass("d-none");
        $("#notification_count")[0].innerText = count;
        $("#skill_notification_count").removeClass("d-none");
        $("#skill_notification_count")[0].innerText = count;
    }

    function ajaxGetNotifications()
    {
        $.ajax({
            type: "GET",
            url: "/getNotifications",
            success: function(data){
                updateNotificationCount(data);
            },
            dataType: "json"
        })
    }

})