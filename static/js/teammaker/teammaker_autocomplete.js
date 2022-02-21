$(document).ready(function(){

    $('#team_leader').devbridgeAutocomplete({
    serviceUrl: '/teammaker/get_users/',
    onSelect: function (suggestion) {
        const leader_element = document.getElementById("team_lead")
        if (leader_element !== null) {
            $(leader_element).attr("value",suggestion.data)
        } else {
            $('<input>').attr({
                type: 'hidden',
                id: 'team_lead',
                name: 'team_lead',
                value: suggestion.data
            }).prependTo('#team_form')
        }
    }
    });

    $('#squadmember').devbridgeAutocomplete({
    serviceUrl: '/teammaker/get_users/',
    onSelect: function (suggestion) {
        const team_member = document.getElementById("member")
        if (team_member !== null) {
            $(team_member).attr("value",suggestion.data)
        } else {
            $('<input>').attr({
                type: 'hidden',
                id: 'member',
                value: suggestion.data
            }).prependTo(this)
        }
    }
    });

    $('#add_role_assignment').on( "click", function () {
        const containerParent = this.parentElement.parentElement;
        const role_holder = this.parentElement.children[0].children[1];

        var role_value = role_holder.selectedOptions[0].value;
        var role_name = role_holder.selectedOptions[0].innerText;

        const squadmate = this.parentElement.children[1].children[1];
        var squadmate_name = squadmate.value;

        let userid = this.previousElementSibling.children[1].children[0].value;
        this.previousElementSibling.children[1].children[0].remove();
        squadmate.value = "";

        var cont = $('<div>').attr({
            'class' : "member_relation mt-3 d-flex flex-md-row justify-content-around w-50 border border-primary bg-warning align-items-center p-2"
        });
        var p1 = ($('<p>').attr({
            "class" : "role_association m-0"
        }));
        var p2 = ($('<p>').attr({
            "class" : "name_association m-0"
        }));
        var hiddenIdPerson = ($('<input>').attr({
            "type" : "hidden",
            "name" : "personID",
            "value": userid
        }));
        var hiddenIdRole = ($('<input>').attr({
            "type" : "hidden",
            "name" : "roles",
            "value": role_value
        }));
        
        p1[0].innerText = role_name;
        p2[0].innerText = squadmate_name

        cont[0].append(p1[0]);
        cont[0].append(p2[0]);
        cont[0].append(hiddenIdPerson[0]);
        cont[0].append(hiddenIdRole[0]);

        containerParent.appendChild(cont[0])
    })

})