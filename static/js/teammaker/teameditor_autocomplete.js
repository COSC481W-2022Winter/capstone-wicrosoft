$(document).ready(function(){

    /* AUTOCOMPLETE SECTION */
    const teamLeader = $("#team_leader"); // team leader input textbox
    const squadMember = $("#squadmember"); // squad member input textbox
    let role = $("#role"); // role selectbox

    squadMember[0].value = ""; // set default textvalue to empty string
    role[0].selectedIndex = 0; // make selected index default to 0 for first entry
    document.getElementById("projects").value = ""; // set default textbox input to empty string for projects textbox

    /* This ties the jquery plugin for the autocomplete
    * to the teamLeader textbox, so when a user types in it
    * the values are showed on the textbox.
    *
    * When a user selects one of the entries from the dropdown/autocomplete
    * that entries' id is stored as a hidden input variable that will be passed
    * to the backend view upon submission of the form. So for this one the team leader
    * id will be hidden in the html with the name: team_lead
    */
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
    /* This event is similar to the ones above but it also calls another function
    * that adds the dom elements to the html page to show the project. Also resets the text
    * input back to empty string allowing the user to type in another project if desired.
    */
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

    /*  EVENT SECTION */

    //Event when a user clicks the add button for adding members and roles.
    $('#add_role_assignment').on( "click", function(){
        let role_select = document.getElementById("role");
        let squadmember_textbox = document.getElementById("squadmember");
        if (role_select.selectedIndex === 0 || squadmember_textbox.value === ""){
            alert("Must choose a role and specify member.")
            return;
        }
        addRoleRelation(this);
    });

    /*
        Event when a member clicks the x button on a member to delete
        The method first checks if the member has the class .delete on their
        container, and if so then we remove that class meaning that a person
        does not want to delete that member.
        Else that means if the .delete is not on the member and a user clicks
        the delete x button then we add .delete which makes the member opaque
        and add a hidden id that takes the id of that current member to delete.
     */
    $(".current_member_delete").on("click", function() {
        if ($(this.parentElement).hasClass("delete")){
            this.parentElement.children[5].remove();
            $(this.parentElement).removeClass("delete");
        } else {
            let hiddenIdPerson = ($('<input>').attr({
                "type": "hidden",
                "name": "member_to_delete_id",
                "value": this.parentElement.children[3].value
            }));
            $(this.parentElement).addClass("delete");
            $(this.parentElement).append(hiddenIdPerson);
        }
    });

    /*
        Works similar to the above method, except it used for the projects.
     */
    $(".delete_project").on("click", function() {
        if ($(this.parentElement).hasClass("delete")){
            this.parentElement.children[3].remove();
            $(this.parentElement).removeClass("delete");
        } else {
            let hiddenIdProject = ($('<input>').attr({
                "type": "hidden",
                "name": "project_to_delete_id",
                "value": this.parentElement.children[1].value
            }));
            $(this.parentElement).addClass("delete");
            $(this.parentElement).append(hiddenIdProject);
        }
    });

    /* FUNCTIONS SECTION */

    /*
        Method takes the project element, created <p> element, hidden <input>
        Creates the grey container that holds the project, and appends it to the
        project element container within the DOM.
     */
    function addProject(currentElement, pElement, inputh){
        const main_container = currentElement.parentElement;
        const project_container = $('<div>').attr({
            "class" : "border bg-light d-flex flex-md-row align-items-center w-100 justify-content-center mt-1"
        });

        project_container[0].append(pElement[0]);
        project_container[0].append(inputh[0]);
        main_container.appendChild(project_container[0]);
    }

    /*
        Used to create the grey container that has the role and the member when a
        user clicks the add button.
     */

    function addRoleRelation(passed){
        const containerParent = passed.parentElement.parentElement;
        const role_holder = passed.parentElement.children[0].children[1];

        let role_value = role_holder.selectedOptions[0].value;
        let role_name = role_holder.selectedOptions[0].innerText;

        const squadmate = passed.parentElement.children[1].children[1];
        let squadmate_name = squadmate.value;

        let userid = passed.previousElementSibling.children[1].children[0].value;
        passed.previousElementSibling.children[1].children[0].remove();
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