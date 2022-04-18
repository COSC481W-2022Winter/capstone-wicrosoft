
$(document).ready(function(){
$("#importUsersList").hide();
      $('#ToggleList').click(function () {
        $("#importUsersTable").hide();
        $("#importUsersList").show();
      });
            $('#ToggleTable').click(function () {
        $("#importUsersList").hide();
        $("#importUsersTable").show();
      });
});
