const csrf = Cookies.get('csrftoken');

$(document).ready(function() {

    addStatusCircles();
    $('.btn.popoverReason').popover();



    $('#skillButton').on("click", showModal)
    $('#closeModal1').on("click", closeModal)
    $('#closeModal2').on("click", closeModal)
    $('#saveSkills').on("click", saveSkills)




} );

function saveSkills(){

    let skillList = {skills :[]};
    console.log($('#newSkillsTable'));
    console.log($('.newSkillsTable'));
   $('.newSkillsTable').children().each(function(index, element){
        // Check if each row is checked to be added
       console.log($('.form-check-input')[index].checked);
       if ($('.form-check-input')[index].checked){
           console.log(element)
           let skill_to_add = element.children[0].textContent;
           console.log(skill_to_add);
           let skillLevel_to_add = $('.skillLevel')[index].value;
           console.log($('.skillLevel')[index].value);

           let intermediateArr = [skill_to_add, skillLevel_to_add];

            skillList.skills.push(intermediateArr);

            console.log(skillList);
       }


    })

    $.ajax({
        type:'POST',
        url:'/skills/save_skills/',
        headers: {'X-CSRFToken': csrf},
        data: JSON.stringify(skillList),
        processData: false,
        contentType: false,
        success: function(data){
            closeModal()
            location.replace("/skills/?success=1");
            }

        });
    // Return list
}
//console.log();
//console.log(element);
function showModal(){
    console.log("got here");
    $('#exampleModal').modal('show');



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

            rowStatusInline.setAttribute("class", "btn popoverReason");

            rowStatusInline.setAttribute("id" ,"popoverReason");
            if(rowStatus.getAttribute("value") === null || rowStatus.getAttribute("value") === 'null' || rowStatus.getAttribute("value")=== '')
                rowStatusInline.setAttribute("data-bs-content", "No reason provided by manager, Contact them directly for further information");
            else
                rowStatusInline.setAttribute("data-bs-content", rowStatus.getAttribute("value"));

            rowStatusInline.setAttribute("data-placement", "right");
            rowStatusInline.setAttribute("title", "Reason");
            rowStatusInline.setAttribute("rel", "popover")
            rowStatusInline.setAttribute("data-bs-trigger", "hover");

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
            rowStatusInline.setAttribute("class", "btn popoverReason");

            rowStatusInline.setAttribute("id" ,"popoverReason");

            rowStatusInline.setAttribute("data-bs-content", "Upon approval or rejection, manager reason if given will be displayed here");

            rowStatusInline.setAttribute("data-placement", "right");
            rowStatusInline.setAttribute("title", "Pending skill");
            rowStatusInline.setAttribute("rel", "popover")
            rowStatusInline.setAttribute("data-bs-trigger", "hover");

            rowStatusInline.textContent = ' Pending';
            rowStatus.append(rowStatusInline);

        }
        else if (rowStatus.textContent === "REJ"|| rowStatus.textContent === 'Rejected') {
            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"rejectedCircle");
            rowStatus.textContent = ' ' ;
            rowStatus.append(circle1);
            let rowStatusInline = document.createElement('p');
            rowStatusInline.setAttribute("class", "btn popoverReason");

            rowStatusInline.setAttribute("id" ,"popoverReason");
            if(rowStatus.getAttribute("value") === null || rowStatus.getAttribute("value") === 'null' || rowStatus.getAttribute("value")=== '')
                rowStatusInline.setAttribute("data-bs-content", "No reason provided by manager, Contact them directly for further information");
            else
                rowStatusInline.setAttribute("data-bs-content", rowStatus.getAttribute("value"));

            rowStatusInline.setAttribute("data-placement", "right");
            rowStatusInline.setAttribute("title", "Reason");
            rowStatusInline.setAttribute("rel", "popover")
            rowStatusInline.setAttribute("data-bs-trigger", "hover");
            rowStatusInline.textContent = ' Rejected';
            rowStatus.append(rowStatusInline);

        }

    }
}






//saved incase userful in future


 // let suggestions;
    // $.getJSON('/skills/get_new_skills/', function(data){
    //
    //     let modalTitle = document.getElementsByClassName("modal-title")[0];
    //     modalTitle.textContent = "Add Skills"
    //     console.log(data);
    //     suggestions =  data.suggestions;
    //     let modalBody = document.getElementsByClassName("modal-body")[0];
    //     modalBody.textContent = "Choose a skill(s) to add";
    //
    // for(let i = 0; i < suggestions.length;i++) {
    //     //console.log(suggestions[i]);
    //     //console.log(suggestions[i].skillName);
    //     let newSkillLine = document.createElement("tr");
    //
    //     let newSkillText = document.createElement("td");
    //     newSkillText.textContent = suggestions[i].skillName;
    //     newSkillLine.append(newSkillText);
    //     newSkillSelector = document.createElement("select")
    //     newSkillSelector.setAttribute("value", "skillLevel");
    //
    //     beginner = document.createElement("option");
    //     beginner.setAttribute("value", "BEG");
    //     beginner.textContent = "Beginner";
    //     newSkillSelector.append(beginner);
    //
    //     intermediate = document.createElement("option");
    //     intermediate.setAttribute("value", "INT");
    //     intermediate.textContent = "Intermediate";
    //     newSkillSelector.append(intermediate);
    //
    //     advanced = document.createElement("option");
    //     advanced.setAttribute("value", "ADV");
    //     advanced.textContent = "Advanced";
    //     newSkillSelector.append(advanced);
    //
    //     expert = document.createElement("option");
    //     expert.setAttribute("value", "EXP");
    //     expert.textContent = "Expert";
    //     newSkillSelector.append(expert);
    //     newSkillLine.append(newSkillSelector);
    //    // console.log(i);
    //     //console.log($("#modal-body").children(i));
    //     modalBody.append(newSkillLine);
    //
    //     $("#modal-body").children().eq(i).append("<td class=\"form-check form-check-inline\">\n" +
    //         "  <input class=\"form-check-input\" type=\"checkbox\" value=\"\" id=\"defaultCheck1\">\n" +
    //         "  <label class=\"form-check-label\" for=\"defaultCheck1\">\n" +
    //         "    Add Skill\n" +
    //         "  </label>\n" +
    //         "</td>");
    //
    //     let checkBoxForm = document.createElement("div");
    //     checkBoxForm.setAttribute('class', 'form-check');
    //     checkBox = document.createElement("input");
    //     checkBox.setAttribute('class', 'form-check-input');
    //    // checkBox.setAttribute('type',)

   //}

  // });