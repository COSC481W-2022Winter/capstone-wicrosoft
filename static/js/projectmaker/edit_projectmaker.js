$(document).ready(function(){

    const projectOwner = $("#project_owner");
    const team = $("#team_search");
    team[0].value = "";

    projectOwner.devbridgeAutocomplete({
    serviceUrl: '/projectmaker/get_users',
    showNoSuggestionNotice: true,
    onSelect: function (suggestion) {
        const leader_element = document.getElementById("project_lead");
        if (leader_element !== null) {
            $(leader_element).attr("value",suggestion.data);
        } else {
            $('<input>').attr({
                type: 'hidden',
                id: 'project_lead',
                name: 'project_lead',
                value: suggestion.data
            }).prependTo('#project_form');
        }
    }
    });

    team.devbridgeAutocomplete({
    serviceUrl: '/projectmaker/get_teams/',
    showNoSuggestionNotice: true,
    onSelect: function (suggestion) {
        const teamInput = document.getElementById("team_attach")
        if (teamInput !== null) {
            $(teamInput).attr("value",suggestion.data)
        } else {
            $('<input>').attr({
                type: 'hidden',
                id: 'team_attach',
                value: suggestion.data
            }).prependTo(this)
        }
    }
    });

        /*
        Event when a user clicks the x button on a team to delete
        The method first checks if the team has the class .delete on their
        container, and if so then we remove that class meaning that a person
        does not want to delete that member.
        Else that means if the .delete is not on the team and a user clicks
        the delete x button then we add .delete which makes the team opaque
        and add a hidden id that takes the id of that current member to delete.
     */
    $(".current_team_delete").on("click", function() {
        if ($(this.parentElement).hasClass("delete")){
            this.parentElement.children[3].remove();
            $(this.parentElement).removeClass("delete");
        } else {
            let hiddenIdPerson = ($('<input>').attr({
                "type": "hidden",
                "name": "team_to_delete_id",
                "value": this.parentElement.children[2].value
            }));
            $(this.parentElement).addClass("delete");
            $(this.parentElement).append(hiddenIdPerson);
        }
    });

    $('#add_team_assignment').on( "click", function(){
        let team_search = document.getElementById("team_search");
        if (team_search.value === ""){
            alert("Must specify a team.")
            return;
        }
        addRoleRelation(this)
    });

    function addRoleRelation(passed){
        const containerParent = passed.parentElement.parentElement;

        const teamEle = passed.parentElement.children[0].children[1];
        let team_name = teamEle.value;

        let teamid = passed.previousElementSibling.children[1].children[0].value;
        passed.previousElementSibling.children[1].children[0].remove();
        teamEle.value = "";

        let cont = $('<div>').attr({
            'class' : "member_relation mt-3 d-flex flex-md-row justify-content-around w-50 border bg-light align-items-center p-2"
        });
        let hiddenIdPerson = ($('<input>').attr({
            "type" : "hidden",
            "name" : "team_to_attach_id",
            "value": teamid
        }));
        let p2 = ($('<p>').attr({
            "class" : "name_association m-0"
        }));
        let closeButton = ($('<span>')).attr({
            "class" : "making_delete rounded-circle bg-white border"
        });

        p2[0].innerText = team_name
        closeButton[0].innerText = "X";

        cont[0].append(p2[0]);
        cont[0].append(closeButton[0]);
        cont[0].append(hiddenIdPerson[0]);

        containerParent.appendChild(cont[0])

        $(".making_delete").on("click", function() {
            this.parentElement.remove();
        });
    }








})