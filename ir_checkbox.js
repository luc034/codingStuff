// javascript for oracle apex to add check boxes to interactive report

// pl sql column
// case when instr(:P1_ITEM, '|' || COLUMN_NAME || '|') > 0 then 
// 'checked' 
// else 
// '' 
// end as selected,

// Column Heading // this: -- </input type> -- is optional
// <input type="checkbox" value="all"></input type><h1 style="color: #4B66A7">Select All</h1>
// Column HTML 
// <input type="checkbox" #SELECTED# value="#COLUMN_NAME#">

// DA selected
var cb$, checked, allRows$,
    sel$ = $("#P1_ITEM"),
    event = this.browserEvent,
    target$ = $(event.target),
    th$ = target$.closest("th"),
    tr$ = target$.closest("tr");


if (th$.length) {
    
    // the click was on the "select all"
    // checkbox or checkbox cell
    cb$ = th$.find("input");
    if (cb$.length && cb$.val() === "all") {
        checked = cb$[0].checked;
        if (target$[0].nodeName !== 'INPUT') {
            
            // only do this if the click was not on the checkbox
            // because the checkbox will check itself
            checked = cb$[0].checked = !checked;
        }
        if (sel$.val() === "") {
            sel$.val("|");
        }
        if (sel$.val() !== "") {
            sel$.val("");
        }
        $("#REPORT_REGION").find("td input").each(function() {
            this.checked = checked;
            // give a visual style to the [un]selected row
            $(this).closest("tr").toggleClass("selected", checked);
            // update the hidden selected item
            sel$.val(sel$.val().replace("|" + this.value + "|", "|"));
            
            if (checked) {
                if (sel$.val() === "") {
                    sel$.val("|");
                }
                //if (sel$.val() === "||") {
                 //   sel$.val("|");
                //}
                // sets each value
               sel$.val(sel$.val() + this.value + "|");
            } 
        });
    }
} else if (tr$.length) {
    // the click was on some other data row
    cb$ = tr$.find("td").first().find("input");
    checked = cb$[0].checked;
    if (target$[0].nodeName !== 'INPUT') {
        // only do this if the click was not on the checkbox but in the column
        // because the checkbox will check itself
        checked = cb$[0].checked = !checked;
    }
    // give a visual style to the [un]selected row
    tr$.toggleClass("selected", checked);
    // update the hidden selected item
    if (checked) {
        if (sel$.val() === "") {
            sel$.val("|");
        }
        sel$.val(sel$.val() + cb$.val() + "|");
    } else {
        sel$.val(sel$.val().replace("|" + cb$.val() + "|", "|"));
        // if just a '|' then clears variable
        if (sel$.val() === "|") {
            sel$.val("");
        }
    }
    // update the select all checkbox state
    allRows$ = $("#REPORT_REGION").find("td input");
    checked = (allRows$.length === allRows$.filter(":checked").length);
    $("#REPORT_REGION").find("th input")[0].checked = checked;
}





// DA refresh
var checked,
    allRows$ = $("#REPORT_REGION").find("td input");
allRows$.filter(":checked").closest("tr").addClass("selected");
checked = (allRows$.length === allRows$.filter(":checked").length);
$("#REPORT_REGION").find("th input")[0].checked = checked;

// CSS for selected values
// .a-IRR-table tr.selected td {
//     background-color: #2d7bbb;
//     color: #fff;
// }
// .a-IRR-table tr.selected:hover td {
//     background-color: #399bea;
//     color: #fff;
// }


// select all by default
var  checked, 
    sel$ = $("#P1_ITEM");

        checked = true;
        if (sel$.val() === "") {
            sel$.val(":");
        }
        if (sel$.val() !== "") {
            sel$.val("");
        }
        $("#REPORT_REGION").find("td input").each(function() {
            this.checked = checked;
            // give a visual style to the [un]selected row
            $(this).closest("tr").toggleClass("selected", checked);
            // update the hidden selected item
            sel$.val(sel$.val().replace(":" + this.value + ":", ":"));
            
                if (sel$.val() === "") {
                    sel$.val(":");
                }
               sel$.val(sel$.val() + this.value + ":");
        });
        $("#REPORT_REGION").find("span input").each(function() {
            this.checked = checked;
            // give a visual style to the [un]selected row
            $(this).closest("th").toggleClass("selected", checked);
            });

