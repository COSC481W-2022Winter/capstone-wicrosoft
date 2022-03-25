$(document).ready(function(){
    const search_entity_container = $("#entity_container");

    let query = "The+";
    let filter = "teams+projects"

    const promise1 = getResponse(query,filter);
    promise1.then(json => {
        doSomething(json).then((cardArray) => displayEntities(cardArray))
    })

    async function getResponse(query, filter){
        let url = query + "/" + filter;
        let json = await $.get(url,null);
        return json;
    }

    async function doSomething(json){
        const teamArray = json.teams;
        console.log(teamArray);
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

            inCont[0].innerText = team.name;
            title[0].innerText = "Members: " + team.member_count;
            desc[0].innerText = team.short_desc;

            cont[0].appendChild(inCont[0]);
            cont[0].appendChild(bodyCont[0]);
            bodyCont[0].appendChild(title[0]);
            bodyCont[0].appendChild(desc[0]);

            cardArray.push(cont[0]);
        })

        return cardArray;
    }

    function displayEntities(cardArray){
        cardArray.forEach((card) => {
            console.log(search_entity_container[0].appendChild(card));
        });
    }

})