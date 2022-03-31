$(document).ready(function(){

    const team = $("#team_search");
    team[0].value = "";

    projectOwner.devbridgeAutocomplete({
    serviceUrl: 'get_users',
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
    serviceUrl: 'get_teams/',
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

    $('#add_team_assignment').on( "click", addRoleRelation);

    function addRoleRelation(){
        const containerParent = this.parentElement.parentElement;

        const teamEle = this.parentElement.children[0].children[1];
        let team_name = teamEle.value;

        let teamid = this.previousElementSibling.children[1].children[0].value;
        this.previousElementSibling.children[1].children[0].remove();
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