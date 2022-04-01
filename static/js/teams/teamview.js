$(document).ready(function(){

    let elementArray = document.getElementsByClassName("teams");
    let linkArray = document.getElementsByClassName("team_edit_link");
    let showTeamElement = document.getElementById("showTeams");
    hide(elementArray, showTeamElement);

    $(showTeamElement).on("click",function() {
            if (showTeamElement.innerText === "Show All")
                show(elementArray, showTeamElement);
            else
                hide(elementArray, showTeamElement);
        });


    function hide(elementArray, showTeamElement)
    {
        if (elementArray.length > 4)
        {
            for (let i = 4; i < elementArray.length; i++)
            {
                $(elementArray[i]).addClass("d-none");
                $(linkArray[i]).addClass("d-none");
            }
        }
        showTeamElement.innerText = "Show All";
    }

    function show(elementArray, showTeamElement)
    {
        for (let i = 4; i < elementArray.length; i++)
        {
            $(elementArray[i]).removeClass("d-none");
            $(linkArray[i]).removeClass("d-none");
        }
        showTeamElement.innerText = "Hide";
    }



})