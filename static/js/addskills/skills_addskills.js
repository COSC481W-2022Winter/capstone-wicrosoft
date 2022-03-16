$(document).ready(function() {

    addStatusCircles();



    $('#skillButton').on("click", showModal)
    $('#closeModal1').on("click", closeModal)
    $('#closeModal2').on("click", closeModal)
    $('#saveSkills').on("click", saveSkills)




} );

function saveSkills(){

    let skillList = {skills :[]};
    $('.modal-body').eq(0).children().each(function(index, element){
        // Check if each row is checked to be added
       if (element.children[2].children[0].checked === true){
           let skill_to_add = element.children[0].textContent;
           console.log(skill_to_add);
           let skillLevel_to_add = element.children[1].value;
           console.log(skillLevel_to_add);

           let intermediateArr = [skill_to_add, skillLevel_to_add];

            skillList.skills.push(intermediateArr);

            console.log(skillList);


           // Create Json Object


           // Add Skill Name


           // Add Proficieny Level


           // Add Object to List

       }


    })
    // Return list
}
//console.log();
//console.log(element);
function showModal(){
    console.log("got here");
    $('#exampleModal').modal('show');
    let suggestions;
    $.getJSON('/skills/get_new_skills/', function(data){

        let modalTitle = document.getElementsByClassName("modal-title")[0];
        modalTitle.textContent = "Add Skills"
        //console.log(data);
        suggestions =  data.suggestions;
        let modalBody = document.getElementsByClassName("modal-body")[0];
        modalBody.textContent = "Choose a skill(s) to add";

    for(let i = 0; i < suggestions.length;i++) {
        //console.log(suggestions[i]);
        //console.log(suggestions[i].skillName);
        let newSkillLine = document.createElement("tr");

        let newSkillText = document.createElement("td");
        newSkillText.textContent = suggestions[i].skillName;
        newSkillLine.append(newSkillText);
        newSkillSelector = document.createElement("select")
        newSkillSelector.setAttribute("value", "skillLevel");

        beginner = document.createElement("option");
        beginner.setAttribute("value", "BEG");
        beginner.textContent = "Beginner";
        newSkillSelector.append(beginner);

        intermediate = document.createElement("option");
        intermediate.setAttribute("value", "INT");
        intermediate.textContent = "Intermediate";
        newSkillSelector.append(intermediate);

        advanced = document.createElement("option");
        advanced.setAttribute("value", "ADV");
        advanced.textContent = "Advanced";
        newSkillSelector.append(advanced);

        expert = document.createElement("option");
        expert.setAttribute("value", "EXP");
        expert.textContent = "Expert";
        newSkillSelector.append(expert);
        newSkillLine.append(newSkillSelector);
       // console.log(i);
        //console.log($("#modal-body").children(i));
        modalBody.append(newSkillLine);

        $("#modal-body").children().eq(i).append("<td class=\"form-check form-check-inline\">\n" +
            "  <input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"defaultCheck1\">\n" +
            "  <label class=\"form-check-label\" for=\"defaultCheck1\">\n" +
            "    Add Skill\n" +
            "  </label>\n" +
            "</td>");

        // let checkBoxForm = document.createElement("div");
        // checkBoxForm.setAttribute('class', 'form-check');
        // checkBox = document.createElement("input");
        // checkBox.setAttribute('class', 'form-check-input');
        //checkBox.setAttribute('type',)

    }

    });


}
function closeModal(){
    $('#exampleModal').modal('hide');
}

function addStatusCircles(){
       let skillstable = document.getElementsByClassName("statsCol");



    for(let i = 0; i < skillstable.length; i++) {
        let rowStatus = skillstable[i];
        //let rowStatus = row.children[2];

            // console.log(rowStatus.textContent);
            // let circle1 = document.createElement("div");
            // circle1.setAttribute("class" ,"approvedCircle");
            // rowStatus.appendChild(circle1);


        if (rowStatus.textContent === 'APP' || rowStatus.textContent === 'Approved') {
            let circle1 = document.createElement("span");
            circle1.setAttribute("class" ,"approvedCircle");
            rowStatus.textContent = '' ;
            rowStatus.append(circle1);
            let rowStatusInline = document.createElement('p');
            rowStatusInline.setAttribute("class", "skillStatus")
            rowStatusInline.textContent = ' Approved';
            rowStatus.append(rowStatusInline);


        }
        else if (rowStatus.textContent === 'PEN' || rowStatus.textContent === 'Pending') {
           // console.log('got here')

            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"pendingCircle");
            rowStatus.textContent = ' ' ;
            rowStatus.append(circle1);
            let rowStatusInline = document.createElement('p');
            rowStatusInline.setAttribute("class", "skillStatus")
            rowStatusInline.textContent = ' Pending';
            rowStatus.append(rowStatusInline);

        }
        else if (rowStatus.textContent === "REJ"|| rowStatus.textContent === 'Rejected') {
            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"rejectedCircle");
            rowStatus.textContent = ' ' ;
            rowStatus.append(circle1);
            let rowStatusInline = document.createElement('p');
            rowStatusInline.setAttribute("class", "skillStatus")
            rowStatusInline.textContent = ' Rejected';
            rowStatus.append(rowStatusInline);

        }

    }
}