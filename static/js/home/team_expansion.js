$(document).ready(function(){
    $(".expansion_activator").on("click", function(){
        let currentSpan = this;
        let expandContainer = this.parentElement.nextElementSibling;
        if ($(expandContainer).hasClass("d-none")) {
            $(expandContainer).removeClass("d-none");
            $(currentSpan).removeClass("down");
            $(currentSpan).addClass("up");
        } else {
            $(expandContainer).addClass("d-none");
            $(currentSpan).removeClass("up");
            $(currentSpan).addClass("down");
        }
    })
})