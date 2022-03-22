$(document).ready(function(){
    const teamLeader = $("#team_leader");
    const squadMember = $("#squadmember");
    let role = $("#role");

    squadMember[0].value = "";
    teamLeader[0].value = "";
    role[0].selectedIndex = 0;
    document.getElementById("projects").value = "";

    teamLeader.devbridgeAutocomplete({
    serviceUrl: '/teammaker/get_users/',
    showNoSuggestionNotice: true,
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

    squadMember.devbridgeAutocomplete({
    serviceUrl: '/teammaker/get_users/',
    showNoSuggestionNotice: true,
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

    $('#projects').devbridgeAutocomplete({
    serviceUrl: '/teammaker/get_projects/',
    showNoSuggestionNotice: true,
    onSelect: function (suggestion) {
        const project = document.getElementById("projects")
        let pEle = $('<p>').attr({
            class: 'single_project m-0'
        })
        let hiddenEle = $('<input>').attr({
            type: 'hidden',
            name: 'proj',
            value: suggestion.data
        })
        pEle[0].innerText = project.value;

        addProject(this,pEle,hiddenEle);
        project.value = "";
    }
    });

    function addProject(currentElement, pElement, inputh){
        const main_container = currentElement.parentElement;
        const project_container = $('<div>').attr({
            "class" : "border bg-light d-flex flex-md-row align-items-center w-100 justify-content-center mt-1"
        });

        project_container[0].append(pElement[0]);
        project_container[0].append(inputh[0]);
        main_container.appendChild(project_container[0]);

    }

    $('#add_role_assignment').on( "click", addRoleRelation);

    function addRoleRelation(){
        const containerParent = this.parentElement.parentElement;
        const role_holder = this.parentElement.children[0].children[1];

        let role_value = role_holder.selectedOptions[0].value;
        let role_name = role_holder.selectedOptions[0].innerText;

        const squadmate = this.parentElement.children[1].children[1];
        let squadmate_name = squadmate.value;

        let userid = this.previousElementSibling.children[1].children[0].value;
        this.previousElementSibling.children[1].children[0].remove();
        squadmate.value = "";
        role[0].selectedIndex = 0;

        let cont = $('<div>').attr({
            'class' : "member_relation mt-3 d-flex flex-md-row justify-content-around w-50 border bg-light align-items-center p-2"
        });
        let p1 = ($('<p>').attr({
            "class" : "role_association m-0"
        }));
        let hiddenIdPerson = ($('<input>').attr({
            "type" : "hidden",
            "name" : "personID",
            "value": userid
        }));
        let p2 = ($('<p>').attr({
            "class" : "name_association m-0"
        }));
        let hiddenIdRole = ($('<input>').attr({
            "type" : "hidden",
            "name" : "roles",
            "value": role_value
        }));
        let closeButton = ($('<span>')).attr({
            "class" : "making_delete bg-white border"
        });

        p1[0].innerText = role_name;
        p2[0].innerText = squadmate_name
        closeButton[0].innerText = "X";

        cont[0].append(p1[0]);
        cont[0].append(p2[0]);
        cont[0].append(closeButton[0]);
        cont[0].append(hiddenIdPerson[0]);
        cont[0].append(hiddenIdRole[0]);

        containerParent.appendChild(cont[0])

        $(".making_delete").on("click", function() {
            this.parentElement.remove();
        });
    }
})