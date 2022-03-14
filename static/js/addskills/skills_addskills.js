$(document).ready(function() {

    let skillstable = document.getElementById("skillsTable");

     let skillstablebody = skillstable.children[1];
    console.log(skillstablebody.tagName);

    for(let i = 0; i < skillstablebody.children.length; i++) {
        let row = skillstablebody.children[i];
        let rowStatus = row.children[2];

            // console.log(rowStatus.textContent);
            // let circle1 = document.createElement("div");
            // circle1.setAttribute("class" ,"approvedCircle");
            // rowStatus.appendChild(circle1);


        if (rowStatus.textContent === 'APP') {
            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"approvedCircle");
            rowStatus.appendChild(circle1);
        }
        else if (rowStatus.textContent === 'PEN') {
           // console.log('got here')

            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"pendingCircle");
            rowStatus.appendChild(circle1);
        }
        else if (rowStatus.textContent === "REJ") {
            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"rejectedCircle");
            rowStatus.appendChild(circle1);
        }

    }

} );