$(document).ready(function (){

    $("#expand_all").on("click", function(){
        expandAllMembers();
    })
    $("#collapse_all").on("click", function(){
        collapseAllMembers();
    })

    $(".emp_name_container").on("click", function(){
        let empNameContainer = this;
        let individualSkillsContainer = this.nextElementSibling;

        if ($(empNameContainer).hasClass("active_emp")){
            $(empNameContainer).removeClass("active_emp");
            $(individualSkillsContainer).addClass("d-none");
        }else{
            $(empNameContainer).addClass("active_emp");
            $(individualSkillsContainer).removeClass("d-none");
        }
    });

    $(".button_for_comment").on("click", function(){
       let spanButtonForComment = this;
       let textModal = this.nextElementSibling;

       if ($(textModal).hasClass("d-none")) {
           $(textModal).removeClass("d-none");
           $("body").addClass("overlay_body");
       }
    });

    $(".close_button").on("click", function(){
        closeModalNested(this)
    })
    $(".done").on("click", function(){
        closeModal(this)
    })

    expandFirst();

    function closeModal(currentElement){
        $(currentElement.parentElement).addClass("d-none");
        $("body").removeClass("overlay_body");
    }
    function closeModalNested(currentElement){
        $(currentElement.parentElement.parentElement).addClass("d-none");
        $("body").removeClass("overlay_body");
    }

    function expandAllMembers(){
        let nameContainers = document.getElementsByClassName("emp_name_container");
        for (let i = 0; i < nameContainers.length; i++){
            let skillContainer = nameContainers[i].nextElementSibling;
            if (!$(nameContainers[i]).hasClass("active_emp")){
                $(nameContainers[i]).addClass("active_emp");
                $(skillContainer).removeClass("d-none");
            }
        }
    }
    function collapseAllMembers(){
        let nameContainers = document.getElementsByClassName("emp_name_container");
        for (let i = 0; i < nameContainers.length; i++){
            let skillContainer = nameContainers[i].nextElementSibling;
            if ($(nameContainers[i]).hasClass("active_emp")){
                $(nameContainers[i]).removeClass("active_emp");
                $(skillContainer).addClass("d-none");
            }
        }
    }

    function expandFirst(){
        let nameContainers = document.getElementsByClassName("emp_name_container");
        try{ nameContainers[0].click(); }
        catch (ex) {}
    }


});