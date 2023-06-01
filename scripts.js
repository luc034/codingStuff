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