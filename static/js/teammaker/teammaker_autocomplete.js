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

    }
    });

})