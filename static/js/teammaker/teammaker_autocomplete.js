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
        console.log(containerParent)

        const role_holder = this.parentElement.children[0].children[1];
        var role_name = role_holder.childNodes[3].firstChild.nodeValue;
        var role_value = role_holder.childNodes[3].value;

        const squadmate = this.parentElement.children[1].children[1];
        var squadmate_value = squadmate.childNodes[0].value;
        var squadmate_name = squadmate.value;

        var cont = $('<div>').attr({
            'class' : "member_relation"
        });

        var p1 = ($('<p>').attr({
            "class" : "role_association"
        }));
        var p2 = ($('<p>').attr({
            "class" : "name_association"
        }));
        p1[0].innerText = role_name;
        p2[0].innerText = squadmate_name
        console.log(cont);
        console.log(p1);
        console.log(p2);

        cont[0].append(p1[0]);
        cont[0].append(p2[0]);

        containerParent.appendChild(cont[0])
    })

})