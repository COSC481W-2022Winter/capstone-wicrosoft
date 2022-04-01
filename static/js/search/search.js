$(document).ready(function(){
    const search_entity_container = $("#entity_container");

    let query = "";
    let currentQuery = "none";
    let filter = [];



    $('.filter_button').on("click", function (){
       if ($(this).hasClass("filter_active")) {
           $(this).removeClass("filter_active");
           filter.splice(filter.indexOf(this.innerText), 1);
       }
       else{
           filter.push(this.innerText);
           $(this).addClass("filter_active");
       }
    });

    $('#search_box').on("input paste",function (){
        if (this.value === "") {
            removeEnitites();
            return;
        }

        query = this.value;

        if (query === currentQuery)
            return;

        doRequest(query,combineFilter());

        currentQuery = query;
    });

    function combineFilter(){
        let finalString = "";
        for (let i = 0; i <= filter.length-1; i++){
            if (i === filter.length-1)
                finalString += filter[i];
            else
                finalString += filter[i] + '+';
        }
        return finalString;
    }

    function doRequest(query, filter) {
        const promise1 = getResponse(query, filter);
        promise1.then(json => {
            doSomething(json).then((cardArray) => displayEntities(cardArray))
        })
    }

    async function getResponse(query, filter){
        let url = query + "/" + filter;
        let json = await $.get(url,null);
        return json;
    }

    async function doSomething(json){
        const teamArray = json.teams;
        const projectArray = json.projects;
        const personArray = json.users;

        let cardArray = [];

        teamArray.forEach((team) => {
            let cont = $("<div>").attr({
            'class' : 'card bg-light mb-3 team rounded-0',
            'style' : 'width: 300px;height:200px;'
            });
            let inCont = $("<div>").attr({
            'class' : 'card-header search_card_name rounded-0'
            });
            let bodyCont = $("<div>").attr("class","card-body");
            let title = $("<h5>").attr("class","card-title");
            let desc = $("<p>").attr("class","card-text");
            let a_link = $("<a>").attr({
                "class" : "title_link",
                "href" : "/teamDisplay/" + team.id
            });

            a_link[0].innerText = team.name;
            inCont[0].appendChild(a_link[0]);
            title[0].innerText = "Members: " + team.member_count;
            desc[0].innerText = team.short_desc;

            cont[0].appendChild(inCont[0]);
            cont[0].appendChild(bodyCont[0]);
            bodyCont[0].appendChild(title[0]);
            bodyCont[0].appendChild(desc[0]);

            cardArray.push(cont[0]);
        })
        projectArray.forEach((project) => {
            let cont = $("<div>").attr({
            'class' : 'card bg-light mb-3 team rounded-0',
            'style' : 'width: 300px;height:200px;'
            });
            let inCont = $("<div>").attr({
            'class' : 'card-header search_card_name rounded-0'
            });
            let bodyCont = $("<div>").attr("class","card-body");
            let title = $("<h5>").attr("class","card-title");
            let desc = $("<p>").attr("class","card-text");
            let a_link = $("<a>").attr({
                "class" : "title_link",
                "href" : "/projectDisplay/" + project.id
            });

            a_link[0].innerText = project.name;
            inCont[0].appendChild(a_link[0]);
            title[0].innerText = "Teams Attached: " + project.team_count;
            desc[0].innerText = project.short_desc;

            cont[0].appendChild(inCont[0]);
            cont[0].appendChild(bodyCont[0]);
            bodyCont[0].appendChild(title[0]);
            bodyCont[0].appendChild(desc[0]);

            cardArray.push(cont[0]);
        })
        personArray.forEach((person) => {
            let cont = $("<div>").attr({
            'class' : 'card bg-light mb-3 team rounded-0',
            'style' : 'width: 300px;height:200px;'
            });
            let inCont = $("<div>").attr({
            'class' : 'card-header search_card_name rounded-0'
            });
            let bodyCont = $("<div>").attr({
                "class" : "card-body",
                "style" : "padding-top:8px;padding-bottom:8px;"
            });
            let title = $("<h5>").attr("class","card-title");
            let teamCont = $("<div>").attr("class","d-flex flex-md-column",);
            let desc = $("<h6>").attr("style","margin-bottom:3px;font-weight:500;font-size:1.05em;");
            let a_link = $("<a>").attr({
                "class" : "title_link",
                "href" : "/userDisplay/" + person.id
            });

            a_link[0].innerText = person.name;
            inCont[0].appendChild(a_link[0]);
            title[0].innerText = person.position;
            desc[0].innerText = "Teams:";

            console.log(person);

            for (let i = 0; i < person.teams.length; i++){
                if (i === 2) break;
                let teamElement = $('<a>').attr({
                    'class' :'user_team',
                    'href' : '/teamDisplay/' + person.teams[i].id
                });
                teamElement[0].innerText = person.teams[i].name;
                teamCont[0].appendChild(teamElement[0]);
            }

            cont[0].appendChild(inCont[0]);
            cont[0].appendChild(bodyCont[0]);
            bodyCont[0].appendChild(title[0]);
            bodyCont[0].appendChild(desc[0]);
            bodyCont[0].appendChild(teamCont[0]);

            cardArray.push(cont[0]);
        })

        return cardArray;
    }

    function displayEntities(cardArray){
        if (search_entity_container[0].children.length !== 0)
            while(search_entity_container[0].firstChild)
                search_entity_container[0].removeChild(search_entity_container[0].firstChild);
        cardArray.forEach((card) => {
            search_entity_container[0].appendChild(card);
        });
    }

    function removeEnitites(){
        if (search_entity_container[0].children.length !== 0)
            while(search_entity_container[0].firstChild)
                search_entity_container[0].removeChild(search_entity_container[0].firstChild);
    }

})