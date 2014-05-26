$(document).ready(function(){
  $(".date-picker").datetimepicker();
  
  $(document).on("click", ".show", function(){
    $(this).addClass("hidden");
    $(this).parent().find(".edit").removeClass("hidden");
    var id = $(this).attr("data-id");
    $("#date_picker_" + id).datetimepicker();
  }); 

  $(document).on("click", ".autosubmit input", function(){
    $(this).parent().submit();
  });

  var table = $("#tasks").stupidtable();

  table.bind('aftertablesort', function (event, data) {
    // data.column - the index of the column sorted after a click
    // data.direction - the sorting direction (either asc or desc)

    var th = $(this).find("th");
    th.find(".arrow").remove();
    var arrow = data.direction === "asc" ? "↑" : "↓";
    th.eq(data.column).append('<span class="arrow">' + arrow +'</span>');
});
});
