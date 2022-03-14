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


        if (rowStatus.textContent === 'APP' || rowStatus.textContent === 'Approved') {
            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"approvedCircle");
            rowStatus.textContent = '' ;
            circle1.textContent = 'Approved';
            rowStatus.append(circle1);
            let rowStatusInline = document.createElement('div');
            rowStatusInline.setAttribute("class", "skillStaus")



        }
        else if (rowStatus.textContent === 'PEN' || rowStatus.textContent === 'Pending') {
           // console.log('got here')

            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"pendingCircle");
            rowStatus.textContent = ' ' ;
            circle1.textContent = 'Pending';
            rowStatus.append(circle1);
        }
        else if (rowStatus.textContent === "REJ"|| rowStatus.textContent === 'Rejected') {
            let circle1 = document.createElement("div");
            circle1.setAttribute("class" ,"rejectedCircle");
            rowStatus.textContent = ' ' ;
            circle1.textContent = 'Rejected';
            rowStatus.append(circle1);
        }

    }

} );