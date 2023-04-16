const text_name = document.querySelector('#post_learning_learning_name');
const text_content = document.querySelector('#post_learning_learning_content');
const text_real = document.querySelector('#post_learning_learning_real');
const count_name = document.querySelector('#count_name');
const count_content = document.querySelector('#count_content');
const count_real = document.querySelector('#count_real');

text_name.addEventListener('keyup', () => {
  count_name.textContent = text_name.value.length;
  
  if (text_name.value.length > 50) {
    count_name.classList.add('alert');
  } else {
    count_name.classList.remove('alert');
  }
});

text_content.addEventListener('keyup', () => {
  count_content.textContent = text_content.value.length;
  
  if (text_content.value.length > 200) {
    count_content.classList.add('alert');
  } else {
    count_content.classList.remove('alert');
  }
});

text_real.addEventListener('keyup', () => {
  count_real.textContent = text_real.value.length;
  
  if (text_real.value.length > 200) {
    count_real.classList.add('alert');
  } else {
    count_real.classList.remove('alert');
  }
});