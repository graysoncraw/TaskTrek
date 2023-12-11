$(document).on("dblclick", ".note", function(){
    console.log('double clicked');
    var current = $(this).find('.note-content').text();
    console.log(current);
    var rowCount = $(this).attr('data-row-count');
    var type = $(this).attr('noteType');

    $(this).html('<textarea class="form-control" style="text-align: center;" id="newcont' + rowCount + '" rows="2">'+current+'</textarea>');
    $("#newcont" + rowCount).focus();
    console.log("#newcont" + rowCount);
    console.log("#note" + rowCount + " .note-content");

    $("#newcont" + rowCount).focus(function() {
        console.log('in');
    }).blur(function() {
        var newcont = $("#newcont" + rowCount).val();
        //$("#note" + rowCount).text(newcont);
        editDBContent(rowCount, type, current, newcont);
    });
});

$(document).ready(function () {
    // Attach a change event listener to all checkboxes with class "myCheckbox"
    $(".noteCheck").change(function () {
        // Check if the checkbox is checked
        var checkboxId = $(this).attr("id");
        var noteText = $(this).siblings(".note").find(".note-content").text();
        var type = $(this).attr('noteCheckType');
        console.log(checkboxId);
        console.log(noteText);
        console.log(type);
        if ($(this).is(":checked")) {
            // If checked, initiate AJAX post for this checkbox
            completeDBNote(checkboxId, noteText, type, "checked");
        } else {
            // If unchecked, initiate another AJAX post for this checkbox
            completeDBNote(checkboxId, noteText, type, "unchecked");
        }
    });

    // Function to initiate AJAX post
    function completeDBNote(checkboxId, noteText, type, status) {
        // Your AJAX post code here
        $.ajax({
            type: "POST",
            url: "NoteCompleteProcess",
            data: { checkboxId: checkboxId, noteText: noteText, type: type, status: status },
            success: function (response) {
                location.reload();
            },
            error: function (error) {
                alert("error");
            }
        });
    }
});

function editDBContent(rowCount, type, current, newcont) {
    $.ajax({
        type: "POST",
        url: "NoteEditProcess",
        data: { rowCount: rowCount, type: type, current: current, newcont: newcont },
        success: function(response) {
            // console.log(rowCount);
            // console.log(type);
            // console.log(current);
            // console.log(newcont);
            // alert("success");
            // $("#note" + rowCount).text(newcont);
            location.reload();
        },
        error: function(error) {
            // Handle the error if needed
            alert("failure");
        }
    });

}

function primaryToggleDropdown() {
    var dropdownContent = document.getElementById("primary-dropdown-content");

    // Check the current display style
    var currentDisplayStyle = dropdownContent.style.display;

    // Toggle the display style
    if (currentDisplayStyle === "block") {
        dropdownContent.style.display = "none";
        console.log("dropped up");
    } else {
        dropdownContent.style.display = "block";
        console.log("dropped down");
    }
}

function secondaryToggleDropdown() {
    var dropdownContent = document.getElementById("secondary-dropdown-content");

    // Check the current display style
    var currentDisplayStyle = dropdownContent.style.display;

    // Toggle the display style
    if (currentDisplayStyle === "block") {
        dropdownContent.style.display = "none";
    } else {
        dropdownContent.style.display = "block";
    }
}

// Assuming date is in the format 'yyyy-MM-dd'
function changeDate(date, amount) {
    var currentDate = date;
    console.log(currentDate);
    var currentDateObj = new Date(currentDate);
    currentDateObj.setDate(currentDateObj.getDate() + amount);

    // Format the new date as 'yyyy-MM-dd'
    var newDate = currentDateObj.toISOString().split('T')[0];

    // Send an AJAX request to update the session on the server
    $.ajax({
        type: 'POST',
        url: 'UpdateDateProcess', // Replace with the actual URL of your servlet or controller
        data: { newDate: newDate },
        success: function(response) {
            console.log('Session date updated successfully');
            location.reload();
        },
        error: function(error) {
            console.error('Error updating session date:', error);
        }
    });
    // For example, you can use AJAX to send the new date to the server and update the session.
}

function openCalendarPopup(date) {
    document.getElementById("calendarPopup").style.display = "block";
    document.getElementById("overlay").style.display = "block";

    generateCalendarTable(date);
}

function closeCalendarPopup() {
    document.getElementById("calendarPopup").style.display = "none";
    document.getElementById("overlay").style.display = "none";
}

function generateCalendarTable(initialDate) {
    // Parse the initial date string
    var currentDate = new Date(initialDate + 'T00:00:00');
    console.log(currentDate);
    var currentMonth = currentDate.getMonth();
    var currentYear = currentDate.getFullYear();

    // Make the month + year header for the table
    var calendarPopup = document.getElementById("calendarPopup");
    var table = document.createElement("table");
    var monthYearRow = table.insertRow();
    var monthYearCell = monthYearRow.insertCell();
    monthYearCell.colSpan = 7; // Span the entire width of the table
    monthYearCell.className = "month-year-header";
    monthYearCell.innerHTML = "<div>" + getMonthName(currentMonth) + " " + currentYear + "</div>";
    var headerRow = table.insertRow();


    // Create header cells
    for (var i = 0; i < 7; i++) {
        var headerCell = headerRow.insertCell();
        headerCell.innerHTML = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][i];
    }


    // Set the date to the first day of the month
    currentDate.setDate(1);

    // Get the day of the week for the first day of the month
    var startDay = currentDate.getDay();

    // Calculate the number of days in the current month
    var daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

    // Create rows and cells for each day
    for (var row = 0; row < 6; row++) {
        var calendarRow = table.insertRow();
        for (var col = 0; col < 7; col++) {
            var calendarCell = calendarRow.insertCell();
            if (row === 0 && col < startDay) {
                // Empty cells before the start of the month
                calendarCell.innerHTML = "";
            } else {
                // Check if the current date is within the current month
                if (currentDate.getMonth() === currentMonth) {
                    // Cells with days in the current month
                    var day = currentDate.getDate();
                    var formattedDay = day < 10 ? '0' + day : day; // Add leading zero if needed
                    calendarCell.className = "calendar-day-cell";
                    calendarCell.innerHTML = formattedDay;

                    // Add onclick event to each cell
                    calendarCell.onclick = function () {
                        var clickedDate = currentYear + '-' + (currentMonth + 1) + '-' + this.innerHTML;
                        // Send an AJAX request to update the session on the server
                        $.ajax({
                            type: 'POST',
                            url: 'UpdateDateProcess',
                            data: { newDate: clickedDate },
                            success: function (response) {
                                console.log('Session date updated successfully');
                                location.reload();
                            },
                            error: function (error) {
                                console.error('Error updating session date:', error);
                            }
                        });
                    };
                }
                currentDate.setDate(currentDate.getDate() + 1);
            }
        }
    }

    // Append the close button
    var closeButton = document.createElement("span");
    closeButton.className = "close-btn";
    closeButton.innerHTML = "&times;";
    closeButton.onclick = function() {
        closeCalendarPopup();
    };
    table.appendChild(closeButton);

    // Append the table to the calendar popup
    calendarPopup.innerHTML = "";
    calendarPopup.appendChild(table);
}

function getMonthName(monthIndex) {
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    return monthNames[monthIndex];
}