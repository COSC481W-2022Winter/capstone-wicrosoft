$(document).ready(function (){

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

    function closeModal(currentElement){
        $(currentElement.parentElement).addClass("d-none");
        $("body").removeClass("overlay_body");
    }
    function closeModalNested(currentElement){
        $(currentElement.parentElement.parentElement).addClass("d-none");
        $("body").removeClass("overlay_body");
    }


});