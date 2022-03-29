$(document).ready(function(){
    const projectOwner = $("#project_owner");

    projectOwner[0].value = "";

    projectOwner.devbridgeAutocomplete({
    serviceUrl: 'get_users',
    showNoSuggestionNotice: true,
    onSelect: function (suggestion) {
        const leader_element = document.getElementById("project_owner")
        if (leader_element !== null) {
            $(leader_element).attr("value",suggestion.data)
        } else {
            $('<input>').attr({
                type: 'hidden',
                id: 'project_owner',
                name: 'project_owner',
                value: suggestion.data
            }).prependTo('#project_form')
        }
    }
    });
})