$(document).ready(function(){

    let elementArray = document.getElementsByClassName("teams");
    let teamEditLinkArray = document.getElementsByClassName("team_edit_link");
    let teamViewLinkArray =  document.getElementsByClassName("team_display_link");
    let showTeamElement = document.getElementById("showTeams");
    hide(elementArray, showTeamElement);

    $(showTeamElement).on("click",function() {
            if (showTeamElement.innerText === "Show All")
                show(elementArray, showTeamElement);
            else
                hide(elementArray, showTeamElement);
        });

    $(".btn.btn-primary.projects.mb-2").on("click", function(){

        //console.log($(this).attr("value"));

        location.assign(window.location.origin + "/projectDisplay/" + $(this).attr("value") + "/");
    })

    function hide(elementArray, showTeamElement)
    {
        if (elementArray.length > 4)
        {
            for (let i = 4; i < elementArray.length; i++)
            {
                $(elementArray[i]).addClass("d-none");
                $(teamEditLinkArray[i]).addClass("d-none");
                $(teamViewLinkArray[i]).addClass("d-none");

            }
        }
        showTeamElement.innerText = "Show All";
    }

    function show(elementArray, showTeamElement)
    {
        for (let i = 4; i < elementArray.length; i++)
        {
            $(elementArray[i]).removeClass("d-none");
            $(teamEditLinkArray[i]).removeClass("d-none");
            $(teamViewLinkArray[i]).removeClass("d-none");
        }
        showTeamElement.innerText = "Hide";
    }





})