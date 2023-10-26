import helpfulFun from './help.js';
import { a, b, c} from './help.js';

// region 


function hasRepeats (str) {
  return /(.).*\1/.test(str);
}

function allCharactersSame(s)
  {
      let n = s.length;
      for (let i = 1; i < n; i++)
          if (s[i] != s[0])
              return false;

      return true;
  }
// region 

apex.event.trigger( "#myRegionStaticID", "apexrefresh" );
apex.region("myRegionStatidID").refresh();


<label class="textarea">
  <input type="text" id="myCheck" onclick="myFunction()">
  <span class="slider round"></span>
</label>

// function area

function myFunction() {
  // Get the checkbox
  var checkBox = document.getElementById("myCheck");

  // If the checkbox is checked, display the output text
  if (checkBox.checked == true){
    apex.item('P38_CHECKBOX_VALUE').setValue('Y');
  } else {
        apex.item('P38_CHECKBOX_VALUE').setValue('N');  
  }
}

function settextareaValue() {

    document.getElementById('P3_COMMENT').textContent= "This is JavaScript"
    
    }


    // const human = {
    //   dna: 'AACTG',
    //   name: 'jeff',
    //   born: Date.now(),
    //   walk() {
    //     console.log('walking');
    //   }
    //   }
      
      human._proto_._proto_;
      
      Object.getPrototypeOf(human);
      
      class human {
        constructor(name) {
        this.dna = 'AACTG';
        this.name = name;
        }
        get gender() {
          return this.gender;
        }
        set gender(val) {
          this.gender = val;
        }
        walk() {
              console.log('walking');
            }
        static isHuman(human) {
          if (human.dna == 'AACTG') {
            return true;
          }
        }
      }

      const list = ['foo', 'bar', 'bar']

      const uniq = new Set(list)

      const dict = new Map([
        ['foo', 1],
        ['bar', 2]

      ])

      const weakDict = new WeakMap([
        ['foo', 1],
        ['bar', 2]

      ])

      setTimeout(() => {
        console.log('5 seconds in the future');
      }, 5000);

      // callback hell
      setTimeout(() => {
        console.log('5 seconds in the future');
        setTimeout(() => {
          console.log('10 seconds in the future');
          setTimeout(() => {
            console.log('15 seconds in the future');
            setTimeout(() => {
              console.log('20 seconds in the future');
            }, 5000);
          }, 5000);
        }, 5000);
      }, 5000);

      const promise = new promise(
        (resolve, reject) => {

          // something async

          if (greatSuccess){
            resolve('success');
          } else {
            reject('failure');
          }
        }
      )

      promise 
      .then(success => {
        console.log('yay!', success);
      })

      .catch(err => {
        console.log('oh no1', err)
      })

      async function asyncFun() {
        try {
          const result = await promise;
      }
      catch (error) {

      }

    }

    // need module bundler
    const btn = document.querySelector('.button');

    btn.addEventListener('click', () => {
      console.log('clicked');

      document.body.style.backgroundColor = 'red';
    });

    function myComponent() {
      const [message, setMessage] = useState();

      return  (
        <div>
          <h1>hello {message}</h1>
          <button onClick={() => setMessage('world')}></button>
        </div>
      )
    }
	
	
	//JavaScript:apex.confirm(“Are you sure you want to delete: #ENAME#?”,{request:”DELETE”,set:{“PX_DELETE_EMP”:#EMPNO#}});//10 Things I Wish I Knew When I Started Using APEX


var el = this.affectedElements[0];
$(el).find("ul").sortable({
    items: 'li'
  , containment: el
  , update: function(event,ui) { updateDisplaySeq(el); }
});

var el = this.affectedElements[0];
$(el).find("table").sortable({
    items: 'tr'
  , containment: el
  , update: function(event,ui) { updateDisplaySeq(el); }
});

var el = this.affectedElements[0];
$(el).find("ToDoRegion").sortable({
    items: 'P1_item'
  , containment: el
  , update: function(event,ui) { updateDisplaySeq(el); }
});

// pRegionID = static ID 

function updateDisplaySeq(pRegionID) {
    var results = $(pRegionID).find("ul.Users").sortable('toArray', {attribute: 'data-id'});
    apex.server.process ( "UPDATE_ORDER",
      {f01:results},
      {
        success: function( pData )
        {
          // apex.jQuery.gritter.add({title: "Todos",text:"New order saved."});
          apex.message.showPageSuccess("New order saved.");
          apex.event.trigger(pRegionID, 'apexrefresh');
        }
      }
    );
  }
  
  var fixHelper = function(e, ui) {
    ui.children().each(function() {
    $(this).width($(this).width());
  });
  return ui;
  }
  function makeSortable(pRegionID) {
  var $r = $("#report_" + pRegionID);
  var r = $r[0];// add ID to TR element so we know the correct position
  $r.find("[headers='ID'] a").each(function(){
  // This selector should work for Theme 26
  // $(this).parents('.uReportBody .uReport tr').attr('data-id',$(this).data("id"));
  $(this).parent().parent().attr('data-id',$(this).data("id"));
  });// finally make it sortable
  $r.find("table.t-Report-report").sortable({
  items: 'tr'
  , containment: r
  , helper: fixHelper
  , update: function(event,ui) { updateDisplaySeq(r); }
  });
  }

var win;
function openurl(pUrl) {
    $('#click').click(function() {
        win = window.open(pUrl, "something", "width=550,height=170");
    });
};

function closeUrl() {
    win.close();
}


//javascript:setTimeout(function() { window.open("url","_blank"); }, 10000);


//javascript:setTimeout(function() { window.open("url","_blank"); }, 10000);
// redirect call to function
javascript:redirectxls("url");
// function that opens url and then uses timeout with lambda function
function redirectxls(pvalue){
  var win;
  win = apex.navigation.openInNewWindow(pvalue);
  setTimeout(()=>{win.close()},5000);
}
  // 

  function redirectxls(pvalue){
    var win;
    win = apex.navigation.openInNewWindow(pvalue);
    setTimeout(()=>{win.close()},5000);
  }
  
  const myModal = document.getElementById('myModal')
  const myInput = document.getElementById('myInput')
  
  myModal.addEventListener('shown.bs.modal', () => {
    myInput.focus()
  })

  // single row view by default
  var ig$ = apex.region("StaticID").widget();
  ig$.interactiveGrid("getActions").invoke("single-row-view");
  
function fn_click_async()
{
    // Call Ajax process to execute some PL/SQL code
    apex.server.process ('ajax_process'  //PL/SQL process name
    ,null
    ,{ dataType : 'json'
    //, async : false
    , success : function(pData)
         {
             // This alert fires first, and then the post processing which is where we would
             // like to execute consecutive set of Javascript code
             //alert('bool: '+ pData.bool);
             //alert('bool: '+ pData.bool);


             //Store the PL/SQL result in a Page item
             apex.item("P1_item").setValue(pData.bool);
             $(this.item).data('id');
         }
    }
    ).done( function(pData)
        {
            // Do the post processing here, next set of code post PL/SQL call
            if (pData.bool){
                //alert('bool: '+ pData.bool);
                alert('Attention: ' + pData.date + ' is a weekend or holiday');
                //apex.message.showPageSuccess('Attention: ' + pData.date + ' is a weekend or holiday'); 
        //$('#t_Alert_Success').attr('style','background-color: #ffe5ad;');
        //$('.t-Alert-title').attr('style','color: black;font-weight: bold;');
       // $('#t_Alert_Success div div.t-Alert-icon span').removeClass('t-Icon').addClass('fa fa-warning');
                // shows dialog box with confirm or cancel buttons
                //apex.message.confirm('Attention: ' + pData.date + ' is a weekend or holiday');
                //apex.confirm('Attention: ' + pData.date + ' is a weekend or holiday');
                // shows dialog box with 1 button
                //apex.message.showDialog('Attention: ' + pData.date + ' is a weekend or holiday');
            }
            //alert('bool: '+ pData.bool);
        }

    );
}



function fn_click_async()
{
    // Call Ajax process to execute some PL/SQL code
    apex.server.process ('process'  //PL/SQL process name
    ,null
    ,{ dataType : 'json'
    //, async : false
    , success : function(pData)
         {
             //Store the PL/SQL result in a Page item
             //apex.item("P60_DUE_DATE_WKD").setValue(pData.bool);
             if (pData.bool){
                alert('Attention: ' + pData.date + ' is a weekend or holiday');
             }
         }
    }
    ).done( function(pData)
        {
            //if (pData.bool){
            //    alert('Attention: ' + pData.date + ' is a weekend or holiday');
            //}
            //win.close();
    //closeUrl();
    //setTimeout(closeUrl(),1000);
    //setTimeout(()=>{win.close()},1000);
   // if (confirm('Would you like to delete this email?')) {

        // Delete it!
    
        //apex.item('p1_item').setValue(value);
        //$s('p1_item',value);
    
        //apex.event.trigger('#p1_item', 'Link_Call', '');
        //apex.event.trigger('#p1_item', 'change', '');

   // } else {

        // Do nothing!

    //}
    
        }

    );
}



if (apex.item('P3_item').value = apex.item('P3_item_ID').value) {

$x_Hide('P3_message');

} else {

$x_Show('P3_item2');

}


$s('P3_item','P3_item_ID');

$v(this.triggingElement)

document.getElementById('P3_item2').textContent = $v('P3_item')

// .apex-item-multi, .apex-item-select, .apex-item-text, .apex-item-textarea, select.listmanager

//How to input text in textarea in JavaScript?
//How to Use textarea Input in JavaScript
//To use the textarea input in JavaScript, you have to get the input values or set the input value to the textarea. For getting the textarea input, use the “getElementById('id')” method with the “value” attribute and for setting the input value, use the “getElementById('id'). value = 'text'”.


//What is the input type of text area?
//The <textarea> tag defines a multi-line text input control. The <textarea> element is often used in a form, to collect user inputs like comments or reviews. A text area can hold an unlimited number of characters, and the text renders in a fixed-width font (usually Courier).

//How to set text area value in JavaScript?
//Approach 1: Set Textarea Value in JavaScript Using the textContent Property
//<textarea id= "text" name= "text" style= "border-width: medium;">This is HTML</textarea>
//<button id= "btn" onclick= "settextValue()">Set Textarea Value</button>
//<textarea id= "text" style= "border-width: medium;">Website</textarea>


javascript:deleteRow(#ITEM#);



function deleteRow(value){

    if (confirm('Would you like to delete this email?')) {

        // Delete it!

        apex.item('P92_DELETE_ID').setValue(value);
        //$s('P92_DELETE_ID',value);
        
        apex.event.trigger('#P92_DELETE_ID', 'Link_Call', '');
        //apex.event.trigger('#P92_DELETE_ID', 'change', '');

    } else {

        // Do nothing!

    }

}














//How to input text in textarea in JavaScript?
//How to Use textarea Input in JavaScript
//To use the textarea input in JavaScript, you have to get the input values or set the input value to the textarea. For getting the textarea input, use the “getElementById('id')” method with the “value” attribute and for setting the input value, use the “getElementById('id'). value = 'text'”.


//What is the input type of text area?
//The <textarea> tag defines a multi-line text input control. The <textarea> element is often used in a form, to collect user inputs like comments or reviews. A text area can hold an unlimited number of characters, and the text renders in a fixed-width font (usually Courier).

//How to set text area value in JavaScript?
//Approach 1: Set Textarea Value in JavaScript Using the textContent Property
//<textarea id= "text" name= "text" style= "border-width: medium;">This is HTML</textarea>
//<button id= "btn" onclick= "settextValue()">Set Textarea Value</button>
//<textarea id= "text" style= "border-width: medium;">Website</textarea>



var cb$, checked, allRows$,
    sel$ = $("#P1_SELECTED"),
    event = this.browserEvent,
    target$ = $(event.target),
    th$ = target$.closest("th"),
    tr$ = target$.closest("tr"),
    va$ = $("#P1_VALUES");


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
            sel$.val(":");
        }
        if (sel$.val() !== "") {
            sel$.val("");
        }
        $("#USERS_REGION").find("td input").each(function() {
            this.checked = checked;
            // give a visual style to the [un]selected row
            $(this).closest("tr").toggleClass("selected", checked);
            // update the hidden selected item
            sel$.val(sel$.val().replace(":" + this.value + ":", ":"));
            
            if (checked) {
                if (sel$.val() === "") {
                    sel$.val(":");
                }
                //if (sel$.val() === "||") {
                 //   sel$.val("|");
                //}
                // sets each value
               sel$.val(sel$.val() + this.value + ":");
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
            sel$.val(":");
        }
        sel$.val(sel$.val() + cb$.val() + ":");
    } else {
        sel$.val(sel$.val().replace(":" + cb$.val() + ":", ":"));
        
        // if just a '|' then clears variable
        if (sel$.val() === ":") {
            sel$.val("");
        }
    }
  
    // update the select all checkbox state
    allRows$ = $("#USERS_REGION").find("td input");
    checked = (allRows$.length === allRows$.filter(":checked").length);
    $("#USERS_REGION").find("th input")[0].checked = checked;
}


var  checked, 
    sel$ = $("#P1_SELECTED"),
    va$ = $("#P1_VALUES");


        checked = true;
        if (sel$.val() === "") {
            sel$.val(":");
        }
        if (sel$.val() !== "") {
            sel$.val("");
        }
        $("#USERS_REGION").find("td input").each(function() {
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
        $("#USERS_REGION").find("span input").each(function() {
            this.checked = checked;
            // give a visual style to the [un]selected row
            $(this).closest("th").toggleClass("selected", checked);
            });


var checked,
    allRows$ = $("#USERS_REGION").find("td input");
allRows$.filter(":checked").closest("tr").addClass("selected");
checked = (allRows$.length === allRows$.filter(":checked").length);
$("#USERS_REGION").find("th input")[0].checked = checked;



function disable_item ( itemName )  
{ 
   $('#'+itemName).addClass('apex_disabled').attr('tabindex','-1');    
   $('#'+itemName+'_LABEL').addClass('apex_disabled').attr('tabindex','-1');
}
function enable_item ( itemName )  
{ 
   $('#'+itemName).removeClass('apex_disabled').removeAttr('tabindex');
   $('#'+itemName+'_LABEL').removeClass('apex_disabled').removeAttr('tabindex');    
}

working 
apex.item("P1_USERS_LIST_3").disable(); // works to disable
var sel$ = $("#P1_USERS_LIST_3");	// gets id
sel$.val()				// gets id
select$ = document.querySelectorAll(".checkbox_group"); // gets entire group
select$[0].id // gets name of group
for (let i = 0; i < 5; i++) { // element.id.length
  var element$ = document.getElementById('P1_USERS_LIST_'+i); // gets each one
    alert(element$.value); // prints each group id
    //alert('P65_USERS_LIST_'+i);//element$.val());
}

// get all page items
const myPageItems = [];
allItems = apex.page.forEachPageItem;
allItems( $( "#wwvFlowForm" ), function( el, name ) {
        myPageItems.push(name);
    }, true );



    
function fn_click_async()
{
    // Call Ajax process to execute some PL/SQL code
    apex.server.process ('IS_WEEKEND'  //PL/SQL process name
    ,null
    ,{ dataType : 'json'
    //, async : false
    , success : function(pData)
         {
             //Store the PL/SQL result in a Page item
             //apex.item("P1_DUE_DATE_WKD").setValue(pData.bool);
             if (pData.bool){
                alert('Attention: ' + pData.date + ' is a weekend or holiday');
             }
         }
    }
    ).done( function(pData)
        {
            //if (pData.bool){
            //    alert('Attention: ' + pData.date + ' is a weekend or holiday');
            //}
            //win.close();
    //closeUrl();
    //setTimeout(closeUrl(),1000);
    //setTimeout(()=>{win.close()},1000);
   // if (confirm('Would you like to delete this email?')) {

        // Delete it!

        //apex.item('P1_DELETE_ID').setValue(value);
        //$s('P1_DELETE_ID',value);
        
        //apex.event.trigger('#P1_DELETE_ID', 'Link_Call', '');
        //apex.event.trigger('#P1_DELETE_ID', 'change', '');

   // } else {

        // Do nothing!

    //}
    
        }

    );
}


javascript:deleteRow(#COLUMN#);
javascript:apex.confirm('Are you sure you want to click ok on this confirm message?','REQUEST_NAME');


function deleteRow(value){

    if (confirm('Would you like to make this record valid?')) {

        // Delete it!

        apex.item('P1_DELETE_ID').setValue(value);
        //$s('P1_DELETE_ID',value);
        
        apex.event.trigger('#P1_DELETE_ID', 'Link_Call', '');

    } else {

        // Do nothing!

    }

}



function refresh_async()
{ 
    // gets type: either initial or resend
    var v_type = $("#P1_RUN_TYPE");
    // Call Ajax process to execute some PL/SQL code
    apex.server.process ('REFRESH_DATA'  //PL/SQL process name
    ,null
    ,{ dataType : 'json'
    , success : function(pData)
         {
             // resets the value for each check box because the value gets wiped when it gets disabled
             reset_checkbox(pData);
             // disables the checkboxes cooresponding to the type.
             disable_checkbox(pData);

         } // end of lambda function main body
    } // end of 3rd parameter lambda function main
    // not used yet, for anything that needs to be changed after the function runs
    ).done( function(pData)
        {

        } // end of done function

    ); // end of apex.server.process 
} // end of refresh_async


function reset_checkbox(pData) {
    // total number of groups 
    var v_count = $("#P1_GROUP_COUNT");
    // used for an array of all the group ID's
    var dis_temp = new Array();
    // a dilimeted list of group ID's
    var v_dis = pData.v_list;
    // splits the group ID's into an array from a dilimeted list 
    dis_temp = v_dis.split(":");
    // loops through each group ID and sets the value    
    for (let i = 0; i < v_count.val(); i++) { 
        // gets each checkbox item
        var element$ = document.getElementById('P1_USERS_LIST_'+i); // gets each one
        // enables each checkbox
        apex.item('P1_USERS_LIST_'+i).enable();
        // sets the checkbox value. list must be organized in same way (organized by username when created)
        element$.value = dis_temp[i];
        } // end of loop: for (let i = 0; i < v_count.val(); i++)
}


function disable_checkbox(pData) {
    // total number of groups 
    var v_count = $("#P1_GROUP_COUNT");
    // used for an array of all the group ID's
    var dis_temp = new Array();
    // a dilimeted list of group ID's
    var v_dis = pData.data;
    // splits the group ID's into an array from a dilimeted list
    dis_temp = v_dis.split(":");
    // loops through each group ID and sets the value    
    for (let i = 0; i < v_count.val(); i++) { // element.id.length
        // gets each checkbox item
        var element$ = document.getElementById('P1_USERS_LIST_'+i); // gets each one
        for (let j = 0; j < dis_temp.length; j++) {
            if(element$.value === dis_temp[j]) {
            // unchecks any check box associated with disabled group ID
            element$.checked = false;
            // enables each checkbox
            apex.item('P1_USERS_LIST_'+i).disable();
            // exits loop when found
            break;
            } // end of if statement: if(element$.value === dis_temp[j])
        } // end of loop: for (let j = 0; j < dis_temp.length; j++) 
    } // end of loop: for (let i = 0; i < v_count.val(); i++)
// used to check html to see page item values
//var element = document.getElementById('P61_USERS_LIST');
//var classes = element.className;
//var inhtml = element.innerHTML;
//alert(inhtml);
}

function check_uncheck(pData) {
    // total number of groups 
    var v_count = $("#P1_GROUP_COUNT");
    // sets checked to true by default
    var checked = true;    
    // checks parameter if it says "unchecked" then sets checked to fasle
    if(pData === "unchecked"){
        checked = false;
    } // end of if statement: if(pData === "unchecked")
    // loops through each group ID and sets the value  
    for (let i = 0; i < v_count.val(); i++) { // element.id.length
        // gets each checkbox item
        var element$ = document.getElementById('P61_USERS_LIST_'+i); // gets each one
        // if the check box is not disabled then sets the objects checked field to the value of the checked variable 
        if (element$.disabled == false){
            // sets element.checked to the checked variable based on the parameter
            element$.checked = checked;
        } // end of if statement: if (element$.disabled == false)
    } // end of loop: for (let i = 0; i < v_count.val(); i++)
}




