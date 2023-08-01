import helpfulFun from './help.js';
import { a, b, c} from './help.js';

// region 

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