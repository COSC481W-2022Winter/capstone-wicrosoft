$(document).ready(function() {
    let counter = 0;

    checkCounterAndEnable();

    function checkCounterAndEnable(){
        // if (counter > 0){
            $(":submit")[0].removeAttr("disabled");
        // }
    }
    function incrementChangeCount(){
        counter++;
    }
})