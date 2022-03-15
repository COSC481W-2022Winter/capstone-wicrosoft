$(document).ready(function() {

    addStatusCircles();



    $('#skillButton').on("click", showModal)
    $('#closeModal1').on("click", closeModal)
    $('#closeModal2').on("click", closeModal)



} );



function showModal(){
    console.log("got here");
    $('#exampleModal').modal('show');
    let suggestions;
    $.getJSON('/skills/get_new_skills/', function(data){

        console.log(data);
       suggestions =  data.suggestions;
         let modalBody = document.getElementsByClassName("modal-body")[0];

    for(let i = 0; i < suggestions.length;i++) {
        console.log(suggestions[i]);
        console.log(suggestions[i].skillName);
        let newSkillLine = document.createElement("li");
        newSkillLine.textContent = suggestions[i].skillName;
        modalBody.append(newSkillLine);
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