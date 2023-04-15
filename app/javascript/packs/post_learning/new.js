const text = document.querySelector('#post_learning_learning_content');
const count = document.querySelector('#count');

text.addEventListener('keyup', () => {
  count.textCount = text.value.length;
  
  if (text.value.length > 100) {
    count.classList.add('alert');
  } else {
    count.classList.remove('alert');
  }
});