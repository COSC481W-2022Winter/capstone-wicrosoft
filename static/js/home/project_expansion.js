$(document).ready(function(){
    $(".project_team_name").on("click", function(){
        let currentElement = this;
        let expandContainer = currentElement.nextElementSibling;
        if ($(expandContainer).hasClass("d-none")) {
            $(expandContainer).removeClass("d-none");
            $(currentElement).addClass("project_active");
        } else {
            $(expandContainer).addClass("d-none");
            $(currentElement).removeClass("project_active");
        }
    })
})