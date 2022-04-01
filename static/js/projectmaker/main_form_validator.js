$(document).ready(function(){
    let counter = 0;


    $(".text_input").on("onblur focusout", function(){checkTextbox(this);})
    $(".date").on("onblur focusout", function(){
        checkDate(this);
    })



    function checkTextbox(textInput){
        console.log(textInput);
        if (textInput.value === "") {
            if ($(textInput).hasClass("clean")){
                $(textInput).removeClass("clean")
                counter--;
            }
            $(textInput).addClass("dirty");
        }
        else {
            if ($(textInput).hasClass("dirty"))
                $(textInput).removeClass("dirty");
            $(textInput).addClass("clean");
            counter++;
        }

    }

    function checkDate(datebox){
        if (datebox.value === ""){
            if ($(datebox).hasClass("clean")){
                $(datebox).removeClass("clean")
                counter--;
            }
            $(datebox).addClass("dirty");
        }
        else {
            if ($(datebox).hasClass("dirty"))
                $(datebox).removeClass("dirty");
            $(datebox).addClass("clean");
            counter++;
        }
    }
});