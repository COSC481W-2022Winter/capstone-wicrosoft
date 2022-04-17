$(document).ready(function(){

    initPopover();
    ajaxGetNotifications();
    setInterval(ajaxGetNotifications, 5000);

    function updateNotificationCount(data)
    {
        let count = data.suggestions.length;
        if (count === 0)  { return; }

        $(".notification_indicator").each(function(){
            $( this ).removeClass("d-none");
        })
        $("#notification_count").removeClass("d-none");
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
                popoverInformation(data.suggestions.length);
            },
            dataType: "json"
        })
    }

    function popoverInformation(count){
        let popoverDOMelement = document.getElementById("clipboard_notify");

        if (count === 0)
            $(popoverDOMelement).attr("data-bs-content","No Skill Review Requests");
        else if (count === 1)
            $(popoverDOMelement).attr("data-bs-content",count+" employee has skills that need review.");
        else
            $(popoverDOMelement).attr("data-bs-content",count+" employees have skills that need review.")
    }

    function initPopover() {
        $('[data-toggle="popover"]').popover()
    }

})