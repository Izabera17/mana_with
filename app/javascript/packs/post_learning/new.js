const text_name = document.querySelector('#post_learning_learning_name');
const text_content = document.querySelector('#post_learning_learning_content');
const text_real = document.querySelector('#post_learning_learning_real');
const count = document.querySelector('#count');

text_name.addEventListener('keyup', () => {
  count.textContent = text_name.value.length;
  
  if (text_name.value.length > 50) {
    count.classList.add('alert');
  } else {
    count.classList.remove('alert');
  }
});

text_content.addEventListener('keyup', () => {
  count.textContent = text_content.value.length;
  
  if (text_content.value.length > 80) {
    count.classList.add('alert');
  } else {
    count.classList.remove('alert');
  }
});

text_real.addEventListener('keyup', () => {
  count.textContent = text_real.value.length;
  
  if (text_real.value.length > 100) {
    count.classList.add('alert');
  } else {
    count.classList.remove('alert');
  }
});